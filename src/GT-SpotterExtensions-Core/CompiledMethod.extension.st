Extension { #name : #CompiledMethod }

{ #category : #'*GT-SpotterExtensions-Core' }
CompiledMethod >> spotterActDefault [
	^ self browse
]

{ #category : #'*GT-SpotterExtensions-Core' }
CompiledMethod >> spotterCriticsFor: aStep [
	<spotterOrder: 90>
	aStep listProcessor
		title: 'Critics';
		items: [ { GTCritics onMethod: self } ];
		itemName: [ :item | item title ];
		itemIcon: [ Smalltalk ui icons smallWarningIcon  ];
		filter: GTFilterSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
CompiledMethod >> spotterForImplementorsFor: aStep [
	<spotterOrder: 10>
	aStep listProcessor
			title: 'Implementors';
			allCandidates: [ self implementors collect: #compiledMethod ];
			filter: GTFilterSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
CompiledMethod >> spotterForSendersFor: aStep [
	<spotterOrder: 10>
	aStep listProcessor
			title: 'Senders';
			allCandidates: [ self senders collect: #compiledMethod ];
			filter: GTFilterSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
CompiledMethod >> spotterItemsFor: aStep [
	"do nothing for compiled method"
]

{ #category : #'*GT-SpotterExtensions-Core' }
CompiledMethod >> spotterPreviewCodeIn: aComposite [
	<spotterPreview: 10>
	aComposite pharoMethod
		title: [ self gtDisplayString ];
		display: [:compiledMethod | 
			' ', compiledMethod getSource];
		smalltalkClass: [self methodClass];
		entity: self.
		
	self flag: 'move "entity: self" somewhere else, maybe'
]

{ #category : #'*GT-SpotterExtensions-Core' }
CompiledMethod >> spotterSelectFor: aStep [
	" ignore :) "
]
