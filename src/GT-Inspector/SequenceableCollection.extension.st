Extension { #name : #SequenceableCollection }

{ #category : #'*gt-inspector' }
SequenceableCollection >> gtInspectorItemsIn: composite [
	^ composite table
		beMultiple;
		display: [ :aCollection | 
			(1 to: self size) collect: [ :index | index -> (self at: index) ] ];
		title: [ :anObject | anObject size asString, ' items' ];
		withSmalltalkSearch;
		column: 'Item' evaluated: [ :assoc |
			[ Text fromString: ((assoc value asString contractTo: 50) replaceAll: String cr with: String space) ] 
							on: Error 
							do: [ Text string: 'error printing' attribute: TextColor red ] ];
		column: 'Index' evaluated: [ :assoc | assoc key asString ];
		send: [ :result | (result notNil and: [result size = 1]) 
				ifTrue: [result anyOne] 
				ifFalse: [self species withAll: result]];
		showOnly: 50;
		helpMessage: 'Quick selection field. Given your INPUT, it executes: self select: [:each | INPUT ]'.
]
