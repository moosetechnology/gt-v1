Extension { #name : #MooseEntity }

{ #category : #'*Moose-Finder' }
MooseEntity >> asMooseFinderItemNamed: aString in: aMooseEntity [
	| itemName |
	itemName := aString capitalized, ': ', self mooseName.
	^ MooseGroup with: self withDescription: itemName
]

{ #category : #'*Moose-Finder' }
MooseEntity >> bookmarkEntity [
	<menuItem: 'Bookmark Entity' category: 'Utilities'>
	
	| groupName group |
	groupName := UIManager default 
		request: 'Enter description'
		initialAnswer: self description.
	(groupName isNil or: [ groupName size = 0 ]) ifTrue: [ ^ self ].
	self bookmarkAs: groupName		
]

{ #category : #'*Moose-Finder' }
MooseEntity >> complexPropertyPragmas [
	| navProps definedProps |
	navProps := (Pragma allNamed: #navigation: from: self class to: MooseEntity)
		sorted: [ :a :b | (a argumentAt: 1) < (b argumentAt: 1) ].
	definedProps := (self mooseDescription allAttributes reject: [ :a | a type isPrimitive ])
		flatCollect: [ :prop | 
			(prop mmClass implementingClass >> prop implementingSelector) pragmas
				select: [ :each | each keyword beginsWith: 'MSEProperty:' ] ].
	^ (OrderedCollection withAll: definedProps)
		addAll: navProps;
		yourself
]

{ #category : #'*Moose-Finder' }
MooseEntity >> gtInspectorActionOpenInMoose [
	<gtInspectorAction>
	^ GLMGenericAction new
		action: [ self openInMoose ];
		icon: MooseIcons mooseIcon asGrayScaleWithAlpha;
		title: 'Open in Moose'
]

{ #category : #'*Moose-Finder' }
MooseEntity >> gtInspectorPresentationsIn: composite inContext: aGTInspector [
	| pragmas |
	super gtInspectorPresentationsIn: composite inContext: aGTInspector.

	pragmas := Pragma 
				allNamed: #moosePresentationOrder: 
				from: self mooseInterestingEntity class 
				to: Object 
				sortedUsing: [: x :y | (x argumentAt: 1) < (y argumentAt: 1)].
	pragmas do: [ :eachPragma | 
		(eachPragma selector findTokens: $:) size = 1 
			ifTrue: [ self mooseInterestingEntity perform: eachPragma selector with: composite ]. 
		(eachPragma selector findTokens: $:) size = 2
			ifTrue: [ self mooseInterestingEntity perform: eachPragma selector with: composite with: aGTInspector ] ]

]

{ #category : #'*Moose-Finder' }
MooseEntity >> mooseDescriptionsOfNumberProperties [
	^ self mooseDescription allAttributes select: [:each | each type = FM3 number ]
]

{ #category : #'*Moose-Finder' }
MooseEntity >> mooseFinderMetanoolIn: composite [
	"<moosePresentationOrder: 10>"
	composite magritte
		title: 'Meta editor';
		titleIcon: MooseIcons mooseEditor;
		display: [:anObject | anObject mooseInterestingEntity ];
		act: [:magritte |
			| result annotationDescription | 
			annotationDescription := MTLAnnotationDescription new.
			result := annotationDescription asMagritteMorph addButtons addWindow callInWorld.
			(result notNil) ifTrue: [ 
				magritte entity mooseInterestingEntity mooseDescription attributes add: annotationDescription.
				magritte update ] ] 
			icon: GLMUIThemeExtraIcons glamorousAdd entitled: 'Add annotation';
		description: [ :anObject | anObject mooseDescription asMagritteDescriptionWithAnnotations ]
]

{ #category : #'*Moose-Finder' }
MooseEntity >> mooseFinderNavigationIn: composite [
	<moosePresentationOrder: 1>
	composite custom: MooseNavigationPresentation new
]

{ #category : #'*Moose-Finder' }
MooseEntity >> mooseFinderPropertiesIn: composite [
	<moosePresentationOrder: 2>
	composite table
		noSelection;
		title: 'Properties';
		titleIcon: MooseIcons mooseProperties;
		display: [ :anObject | anObject mooseInterestingEntity mooseDescription allPrimitiveAttributes ];
		sorted: [:x :y | x name < y name];
		column: 'Properties' evaluated: [:each | each name ];
		column: 'Value' evaluated: [:each :anObject | [(anObject mooseInterestingEntity mmGetProperty: each) asString] on: Error do: ['error'] ];
		when: [ :anObject | 
			(anObject mooseInterestingEntity isKindOf: MooseEntity) and: [
				anObject mooseInterestingEntity mooseDescription notNil and: [anObject mooseInterestingEntity mooseDescription allPrimitiveAttributes notEmpty] ]].
]

{ #category : #'*Moose-Finder' }
MooseEntity >> mooseIcon [
	^ MooseIcons mooseMetamodelEntity
]

{ #category : #'*Moose-Finder' }
MooseEntity >> mooseSpecificSpotterProcessorsFor: aSpotterStep [
	| entity assocs pragmaValueAssociations |
	entity := self mooseInterestingEntity.
	pragmaValueAssociations := entity complexPropertyPragmas
		collect: [ :pragma | pragma -> (self mooseInterestingEntity perform: pragma selector) mooseInterestingEntity ].
	assocs := (pragmaValueAssociations
		reject: [ :association | association value isNil or: [ association value isCollection and: [ association value isEmpty ] ] ])
		sorted: [ :a :b | (a key argumentAt: 1) asLowercase asString < (b key argumentAt: 1) asLowercase asString ].
	assocs
		do: [ :assoc | 
			aSpotterStep listProcessor
				allCandidates: [ assoc value asMooseGroup ];
				title: (assoc key argumentAt: 1);
				itemIcon: #mooseIcon;
				filterUsing: GTFilterSubstring;
				itemName: #mooseDisplayString ]
]

{ #category : #'*Moose-Finder' }
MooseEntity >> openInEasel [

	^ self openInGlamorousRoassalEasel
]

{ #category : #'*Moose-Finder' }
MooseEntity >> openInGlamorousEditor [
	<menuItem: 'In Glamour Editor' category: 'Browse'> 

	| symbol className prefixesToIgnore |
	prefixesToIgnore := #( 'FAMIX' 'MSE' 'Moose').
	className := self class name asString.
	prefixesToIgnore do: [:each |
		(className beginsWith: each) ifTrue: [
			className := className copyFrom: each size + 1 to: className size] ].
	symbol := className at: 1 put: className first asLowercase; yourself.
	^ (GLMEditor openOn: { symbol asSymbol -> self }) maximize
]

{ #category : #'*Moose-Finder' }
MooseEntity >> openInGlamorousRoassalEasel [
	<menuItem: 'In Roassal Easel' category: 'Browse'> 

	| symbol className prefixesToIgnore |
	prefixesToIgnore := #( 'FAMIX' 'MSE' 'Moose').
	className := self class name asString.
	prefixesToIgnore do: [:each |
		(className beginsWith: each) ifTrue: [
			className := className copyFrom: each size + 1 to: className size] ].
	symbol := className at: 1 put: className first asLowercase; yourself.
	^ (GLMRoassal2Easel openOn: { symbol asSymbol -> self }) maximize
]

{ #category : #'*Moose-Finder' }
MooseEntity >> spotterProcessorsFor: aSpotterStep [
	super spotterProcessorsFor: aSpotterStep.
	self mooseSpecificSpotterProcessorsFor: aSpotterStep
]
