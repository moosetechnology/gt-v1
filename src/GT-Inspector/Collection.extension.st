Extension { #name : #Collection }

{ #category : #'*gt-inspector' }
Collection >> gtInspectorItemsIn: composite [
	<gtInspectorPresentationOrder: 30>  
	^ (composite list)
		beMultiple;
		display: [ :aCollection | self ];
		title: [ :anObject | anObject size asString, ' items' ];
		searchOn: [:text :each | 
			Compiler evaluate: '| entity each | each := self. entity := each.', text for: each logged: false];		
		format: [ :each |
			[ Text fromString: ((each asString contractTo: 50) replaceAll: String cr with: String space) ] 
							on: Error 
							do: [ Text string: 'error printing' attribute: TextColor red ] ];
		send: [ :result | (result notNil and: [result size = 1]) 
				ifTrue: [result anyOne] 
				ifFalse: [self species withAll: result]];
		showOnly: 50;
		helpMessage: 'Quick selection field. Given your INPUT, it executes: self select: [:each | INPUT ]'.
]
