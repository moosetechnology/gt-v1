"
self open
"
Class {
	#name : #MooseMetaBrowser,
	#superclass : #GLMBrowserTemplate,
	#category : #'Moose-Finder'
}

{ #category : #opening }
MooseMetaBrowser class >> open [
	^ self new openOn: MooseModel meta
]

{ #category : #building }
MooseMetaBrowser >> browserActions [
	browser
		morphicAct: [ :b | 
					MooseModel resetMeta.
					browser entity: MooseModel meta.
					browser update ]
			icon: GLMUIThemeExtraIcons glamorousRefresh
			entitled: 'Reinitialize meta descriptions';
		morphicAct: [ :b :repo | self openLintBrowserOn: repo ] entitled: 'Check metamodel rules';
		morphicAct: [ :b :repo | MooseFameView new openOn: repo ] entitled: 'View class diagram';
		morphicAct: [:b :repo |
					| request selectedClass |
					request := GLMSingleSpotterRequest new 
							searchBlock: [ :string | 
									(repo classes sorted: [:x :y | x fullName < y fullName ]) 
									select: [:each | '*', string, '*' match: each fullName] ];
							labelBlock: [ :class | class fullName ];
							iconBlock: [ :class | class new mooseIcon ].
					selectedClass := GLMSpotterRequest new 
							add: request;
							prompt: 'Find Entity';
							signal.
					selectedClass notNil ifTrue: [ (b pane port: #entityToSelect) value: selectedClass ].
					]
			on: $/ 
			icon: MooseIcons mooseSearch 
			entitled: 'Find entity'
]

{ #category : #building }
MooseMetaBrowser >> buildBrowser [
	| com commentPrag edges |
	browser := GLMTabulator new.
	browser title: 'Moose Meta Browser' translated.
	browser 
		column: [:c | c row: #explorer; row: #details ] span: 3; 
		column: #comments.
	self browserActions.
	(browser transmit)
		fromOutsidePort: #entity;
		to: #explorer port: #metarepository.
	(browser transmit)
		to: #explorer;
		andShow: [ :a | a custom: MooseMetaExplorer new browser noTitle ].
	(browser transmit)
		to: #details;
		fromOutsidePort: #entity;
		from: #explorer port: #selectedEntity;
		from: #explorer port: #selectedAttribute;
		andShow: [ :a | self metamodelMapIn: a ].
	(browser transmit)
		to: #comments;
		from: #explorer port: #selectedEntity;
		from: #explorer port: #selectedAttribute;
		andShow: [ :a | self commentsIn: a ].
	(browser transmit)
		to: #explorer port: #entityToSelect;
		from: #details;
		when: [:x | x class = FM3MetaDescription ].
	browser transmit 
		to: #explorer port: #entityToSelect;
		fromOutsidePort: #entityToSelect.
	^ browser
]

{ #category : #private }
MooseMetaBrowser >> commentOfProperty: fm3Prop [
	| com commentPrag |
	fm3Prop mmClass implementingClass isNil ifTrue: [^ ''].
	com := ''.
	commentPrag := Pragma 
		inMethod: fm3Prop compiledMethod
		named: #MSEComment:.
	commentPrag 
		ifNotNil: [ com := commentPrag argumentAt: 1 ]
		ifNil: [
			commentPrag := Pragma 
				inMethod: fm3Prop compiledMethod
				named: #property:longName:description:.
			commentPrag ifNotNil: 
				[ com := (commentPrag argumentAt: 2) , '. ' , (commentPrag argumentAt: 3) ] ].
	^ com 
]

{ #category : #building }
MooseMetaBrowser >> commentsIn: a [
	a text
		title: 'Comment' translated;
		display: [ :fm3Class | fm3Class implementingClass isNil ifTrue: [''] ifFalse: [fm3Class implementingClass comment] ];
		useExplicitNotNil;
		when: [ :fm3Class :fm3Prop | fm3Class notNil and: [ fm3Prop isNil ]];
		act: [:text :fm3Class | fm3Class implementingClass ifNotNil: [fm3Class implementingClass comment: text text] ] 
			icon: MooseIcons mooseAccept 
			entitled: 'Accept'.
	a text
		title: 'Comment' translated;
		display: [ :fm3Class :fm3Prop | self commentOfProperty: fm3Prop ];
		when: [ :fm3Class :fm3Prop | fm3Prop notNil ]
]

{ #category : #private }
MooseMetaBrowser >> lintRules: aCollectionOfLintRules group: aString [

	| lintRules |
	lintRules := aCollectionOfLintRules select: [:rule| rule group = aString].
	^ RBCompositeLintRule 
			rules: lintRules asArray
			name: aString

]

{ #category : #private }
MooseMetaBrowser >> metamodelLintRules [

	| basicRules rules |
	basicRules := RBCompositeLintRule rulesFor: RBBasicLintRule.
	rules := RBCompositeLintRule rules: 
		{self lintRules: basicRules group: 'Fame'. 
		self lintRules: basicRules group: 'FAMIX' }
			name: 'Fame/FAMIX checks'.
	^ RBCompositeLintRule rules: {rules} name: 'Metamodel checks'
]

{ #category : #building }
MooseMetaBrowser >> metamodelMapIn: a [
	a roassal2
		title: 'Map' translated;
		initializeView:[RTMondrianViewBuilder new];
		painting: [ :view :all :fm3Class :fm3Prop | 
			self viewClass: fm3Class property: fm3Prop in: all on: view];
		useExplicitNotNil;
		when: [ :fm3Class | fm3Class notNil ]
]

{ #category : #private }
MooseMetaBrowser >> openLintBrowserOn: aFMMetaRepository [

	| classes |
	classes := aFMMetaRepository classes collect: [:meta| meta implementingClass].
	CriticBrowser 
		openOnRule: self metamodelLintRules 
		onEnvironment: (RBBrowserEnvironment new forClasses: classes)
]

{ #category : #private }
MooseMetaBrowser >> viewClass: fm3Class property: fm3Prop in: all on: view [
	| edges elements |
	
	view interaction popupText: [:each | each fullName asString].
	view shape rectangle
		fillColor: [ :each | each = fm3Class ifTrue: [ Color blue muchLighter ] ifFalse: [
				each implementingClass organization classComment isNotEmpty ifTrue:[ Color white] ifFalse:[Color lightRed]
				] ];
		borderColor: [ :each | each = fm3Class ifTrue: [ Color blue lighter ] ifFalse: [ Color gray ] ];
		height: [ :each | each complexAttributes size * 2 + 5 ];
		width: [ :each | each primitiveAttributes size ].
	elements := view nodes: all classes.
	edges := view edgesFrom: #superclass.
	fm3Class notNil ifTrue: [
		view shape line 
			color: Color blue muchLighter ;
			width: [:each | each = fm3Prop ifTrue: [ 3 ] ifFalse: [ 1 ] ].
		view 
			edges: fm3Class allComplexAttributes 
			from: fm3Class 
			to: [ :attr | attr type ] ].
	view treeLayout userDefinedEdges: edges
]
