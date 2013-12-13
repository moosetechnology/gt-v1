Extension { #name : #Dictionary }

{ #category : #'*gt-inspector' }
Dictionary >> gtInspectorAssociationsIn: composite [
	<gtInspectorPresentationOrder: 40>
	^ (composite table)
		display: [:anObject | self associations];
		column: 'Key' evaluated:  [:each | 
			[ Text fromString: ((each key asString contractTo: 50) replaceAll: String cr with: String space) ] 
							on: Error 
							do: [ Text string: 'error printing' attribute: TextColor red ]];
		column: 'Value' evaluated: [:each | 
			[ Text fromString: ((each value asString contractTo: 50) replaceAll: String cr with: String space) ] 
							on: Error 
							do: [ Text string: 'error printing' attribute: TextColor red ]];
		beMultiple;
		title: [ :anObject | self size asString, ' associations' ];
		searchOn: [:text :each | 
			Compiler evaluate: ' | entity each | each := self. entity := each.', text for: each logged: false];		
		send: [ :result | result size = 1 ifTrue: [result anyOne] ifFalse: [result]];
"		icon: [ :each |  
			| iconName |
			iconName := each class theNonMetaClass browserIcon ifNil: [#blank].
			OBMorphicIcons iconNamed: iconName ];"
		showOnly: 50;
		helpMessage: 'Quick selection field. Given your INPUT, it executes: self select: [:each | INPUT ]'.
]

{ #category : #'*gt-inspector' }
Dictionary >> gtInspectorItemsIn: composite [
	^ (composite list)
		display: [ self values ];
		format: [ :each |
			[ Text fromString: ((each asString contractTo: 50) replaceAll: String cr with: String space) ] 
							on: Error 
							do: [ Text string: 'error printing' attribute: TextColor red ]];
		beMultiple;
		title: [ self size asString, ' items' ];
		searchOn: [:text :each | 
			Compiler evaluate: ' | entity each | each := self. entity := each.', text for: each logged: false];		
		send: [ :result | result size = 1 ifTrue: [result anyOne] ifFalse: [result]];
		showOnly: 50;
		helpMessage: 'Quick selection field. Given your INPUT, it executes: self select: [:each | INPUT ]'
]

{ #category : #'*gt-inspector' }
Dictionary >> gtInspectorRetrieveVariableValuePairs [  
	^ OrderedCollection new 
		add: ( 'self' -> self); 
		add: ( 'tally' -> self size );
		add: ( 'array' -> self array );
		yourself

]
