Extension { #name : #CompiledMethod }

{ #category : #'*GT-SpotterExtensions-Core' }
CompiledMethod >> spotterActDefault [
	^ self browse
]

{ #category : #'*GT-SpotterExtensions-Core' }
CompiledMethod >> spotterForImplementorsFor: aStep [
	<spotterOrder: 10>
	aStep listProcessor
			title: 'Implementors';
			allCandidates: [ self implementors collect: #compiledMethod ];
			itemName: [ :method | method printString ];
			matchSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
CompiledMethod >> spotterForSendersFor: aStep [
	<spotterOrder: 10>
	aStep listProcessor
			title: 'Senders';
			allCandidates: [ self senders collect: #compiledMethod ];
			itemName: [ :method | method printString ];
			matchSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
CompiledMethod >> spotterItemsFor: aStep [
	"do nothing for compiled method"
]

{ #category : #'*GT-SpotterExtensions-Core' }
CompiledMethod >> spotterPreviewIn: aComposite [

	aComposite pharoMethod
		title: 'Preview';
		display: [:compiledMethod | 
			' ', compiledMethod getSource];
		smalltalkClass: #methodClass;
		entity: self.
		
	self flag: 'move "entity: self" somewhere else, maybe'
]
