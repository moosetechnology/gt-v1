Extension { #name : #SequenceableCollection }

{ #category : #'*gt-inspector' }
SequenceableCollection >> gtInspectorItemsIn: composite [
	^ composite table
		title: [ :anObject | anObject size asString, ' items' ];
		display: [ :aCollection | (1 to: self size) collect: [ :index | index -> (self at: index) ] ];
		beMultiple;
		withSmalltalkSearch;
		column: 'Item' evaluated: [ :assoc | GTObjectPrinter asSimpleTextFrom: assoc value ];
		column: 'Index' evaluated: [ :assoc | assoc key asString ];
		send: [ :result | (result notNil and: [result size = 1]) 
				ifTrue: [result anyOne] 
				ifFalse: [self species withAll: result]];
		showOnly: 50;
		helpMessage: 'Quick selection field. Given your INPUT, it executes: self select: [:each | INPUT ]'.
]
