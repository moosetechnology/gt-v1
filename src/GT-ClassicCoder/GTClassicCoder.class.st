"
self open maximize
""| browser |
browser := self new browser.
browser openOn: RPackageOrganizer default.
browser inspect""
"
Class {
	#name : #GTClassicCoder,
	#superclass : #GLMGlobalBrowserTemplate,
	#category : #'GT-ClassicCoder'
}

{ #category : #'as yet unclassified' }
GTClassicCoder class >> open [
	^ self openOn: RPackageOrganizer default

]

{ #category : #building }
GTClassicCoder >> browserActionsIn: b [
	b morphicAct: [:theBrowser :organizer |
				| selected  composite packageRequest classRequest |
				composite  := GLMSpotterRequest new.

				packageRequest := GLMSingleSpotterRequest new 
						prompt: 'Find Package';
						searchBlock: [ :string | 
							organizer packages select: [:each |
								GLMSingleSpotterRequest substring: string matches: each name caseSensitive: false ] ];
						labelBlock: [ :p | p name ].
				classRequest := GLMSingleSpotterRequest new 
						prompt: 'Find Class';
						searchBlock: [ :string | 
							Smalltalk allClassesAndTraits select: [:each |
								GLMSingleSpotterRequest substring: string matches: each name caseSensitive: false ] ];
						labelBlock: [ :c | c name ].
						
				selected := composite add: packageRequest; add: classRequest; signal.
				(selected isKindOf: RPackage)
					ifTrue: [ (b pane port: #packageToSelect) value: selected ].
				(selected isKindOf: Behavior )
					ifTrue: [ (b pane port: #classToSelect) value: selected ].
				]
			on: $/ 
			icon: MooseIcons mooseSearch 
			entitled: 'Find package'
]

{ #category : #building }
GTClassicCoder >> buildBrowser [
	"
	| browser |
	browser := self new browser.
	browser openOn: RPackageOrganizer default.
	browser"
	browser := GLMTabulator new.
	browser title: 'Glamorous Classic Coder'.
	self browserActionsIn: browser.
	browser column: #packages; column: #classes; column: [:c |
		c row: #categoriesAndMethods; row: #details ] span: 4.
	browser transmit 
		to: #packages; 
		andShow: [ :a | self packagesIn: a ].
	browser transmit 
		from: #packages; 
		to: #classes; 
		andShow: [ :a | self classesIn: a ].
	browser transmit
		from: #packages;
		from: #classes;
		to: #categoriesAndMethods;
		transformed: [:package :class | {package . class}];
		andShow: [ :a | self categoriesAndMethodsIn: a ].
	browser transmit 
		from: #packages;
		from: #classes;
		from: #categoriesAndMethods port: #selectedMethod;
		to: #details;
		andShow: [ :a | self detailsIn: a ].
	browser transmit to: #packages port: #selection; fromOutsidePort: #packageToSelect.
	browser transmit to: #packages port: #selection; fromOutsidePort: #classToSelect; transformed: #package.
	browser transmit to: #classes port: #selection; fromOutsidePort: #classToSelect.

	browser transmit toOutsidePort: #focusOnMethod; from: #details port: #focusOnMethod.
	browser transmit to: #packages port: #selection; fromOutsidePort: #focusOnMethod; transformed: [:method | method packageFromOrganizer: RPackageOrganizer default].
	browser transmit to: #classes port: #selection; fromOutsidePort: #focusOnMethod; transformed: [:method | method methodClass ].
	browser transmit to: #categoriesAndMethods port: #focusOnMethod; fromOutsidePort: #focusOnMethod.
	^ browser
]

{ #category : #building }
GTClassicCoder >> categoriesAndMethodsIn: a [
	a custom: (GTClassicCoderInstanceAndMetaCategoriesMethods new browser)
]

{ #category : #others }
GTClassicCoder >> classPointOfViewBrowser [
	"self new classPointOfViewBrowser openOn: RPackageOrganizer default"
	browser := GLMTabulator new.
	browser column: #packages; column: #classes; column: #definingPackages; column: #methods.
	browser transmit to: #packages; andShow: [ :a |
		a list 
			display: [ :organizer | organizer packages asSortedCollection: [ :x :y | x name < y name ] ];
			format: #name ].
	browser transmit to: #classes; from: #packages; andShow: [ :a | 
		a list
			display: [ :package | package classes ];
			format: [ :each :package |
				(package extendsClass: each)
					ifTrue: [Text string: each name asString attribute: TextColor gray]
					ifFalse: [each name asString] ];
			selectionAct: [:list | list selection inspect] on: $/ entitled: 'Inspect' ].
	browser transmit to: #definingPackages; from: #classes; andShow: [ :a | 
		a list 
			display: [ :class | class packages];
			format: #name ].
	browser transmit to: #methods; from: #definingPackages; from: #classes; andShow: [ :a | 
		a list 
			title: 'Instance';
			display: [ :package :class | package selectorsForClass: class ];
			selectionAct: [:list :package :class | (Array with: package with: class with: list selection) inspect  ] on: $/ entitled: 'Inspect';
			format: [:each :package :class |
				(package includesSelector: each ofClass: class) 
					ifFalse: [Text string: each asString attribute: TextColor gray]
					ifTrue: [each asString] ].
		a list 
			title: 'Meta';
			display: [ :package :class | class theMetaClass selectors ];
			format: [:each :package :class |
				(package includesSelector: each ofClass: class class) 
					ifFalse: [Text string: each asString attribute: TextColor gray]
					ifTrue: [each asString] ] ].
	^ browser
]

{ #category : #reusable }
GTClassicCoder >> classReferencesIn: a [
	(a list)
		title: 'References';
		useExplicitNotNil;
		when: [ :package :class | class notNil ];
		display: [ :package :class | self systemNavigation allCallsOn: (self globals associationAt: class theNonMetaClass name) ];
		selectionPopulate: #focusOnMethod
			on: $j
			entitled: 'Jump there'
			with: [ :list | list selection compiledMethod ];
		updateOn: SystemAnnouncement from: SystemAnnouncer uniqueInstance
]

{ #category : #reusable }
GTClassicCoder >> classSourceIn: a [
	a smalltalkCode
		title: 'Class';
		useExplicitNotNil;
		when: [ :package :class :method | class notNil and: [ method isNil ] ];
		display: [ :package :class | class definition ]
]

{ #category : #reusable }
GTClassicCoder >> classesIn: a [ 
	a list
		title: 'Classes';
		display: [ :package | package classes];
		sorted: [:x :y | x name < y name ];
"		icon: [ :each | 
			each theNonMetaClass browserIcon isNil 
				ifFalse: [ OBMorphicIcons iconNamed: each theNonMetaClass browserIcon ]
				ifTrue: [ nil ] ];"
		format: [ :each :package |
			(package extendsClass: each)
				ifTrue: [Text string: each name asString attribute: TextColor gray]
				ifFalse: [each name asString] ];
		selectionAct: [:list | list selection inspect] on: $i entitled: 'Inspect';
		updateOn: SystemAnnouncement from: SystemAnnouncer uniqueInstance
]

{ #category : #reusable }
GTClassicCoder >> detailsIn: a [
	self methodSourceCodeIn: a.
	self classSourceIn: a.
	self classReferencesIn: a.
	self sendersIn: a.
	self implementorsIn: a
]

{ #category : #accessing }
GTClassicCoder >> entity [
	^ RPackageOrganizer default
]

{ #category : #others }
GTClassicCoder >> globals [ 
	^ Smalltalk globals
]

{ #category : #reusable }
GTClassicCoder >> implementorsIn: a [
	(a list)
		title: 'Implementors';
		display: [ :package :class :method | (self systemNavigation allImplementorsOf: method selector) ];
		selectionPopulate: #focusOnMethod
			on: $j
			entitled: 'Jump there'
			with: [ :list | list selection compiledMethod ];
		updateOn: SystemAnnouncement from: SystemAnnouncer uniqueInstance
]

{ #category : #reusable }
GTClassicCoder >> methodSourceCodeIn: a [
	a smalltalkCode 
		title: 'Method';
		smalltalkClass: [:package :class | class ];
		act: [:text :package :class | class compile: text text notifying: nil ] 
			icon: GLMUIThemeExtraIcons glamorousAccept 
			on: $s
			entitled: 'Accept';
		act: [:text :package :class :method | class removeSelector: method selector ] 
			icon: GLMUIThemeExtraIcons glamorousRemove
			on: $x
			entitled: 'Remove';
		display: [:package :class :method |
			method getSource ]
]

{ #category : #reusable }
GTClassicCoder >> packagesIn: a [ 
	a list 
		title: 'Packages';
		display: [ :organizer | organizer packages ];
		sorted: [:x :y | x name < y name ];
		format: [:each | each name];
		updateOn: SystemAnnouncement from: SystemAnnouncer uniqueInstance
]

{ #category : #reusable }
GTClassicCoder >> sendersIn: a [
	(a list)
		title: 'Senders';
		display: [ :package :class :method | self systemNavigation allSendersOf: method selector];
		selectionPopulate: #focusOnMethod
			on: $j
			entitled: 'Jump there'
			with: [ :list | list selection compiledMethod ];
		updateOn: SystemAnnouncement from: SystemAnnouncer uniqueInstance
]
