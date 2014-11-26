Extension { #name : #CompiledMethod }

{ #category : #'*GT-Spotter' }
CompiledMethod >> spotterActDefault [
	^ self browse
]

{ #category : #'*GT-Spotter' }
CompiledMethod >> spotterForImplementorsFor: aStep [
	<spotterOrder: 10>
	aStep listProcessor
			title: 'Implementors';
			allCandidates: [ self implementors collect: #compiledMethod ];
			itemName: [ :method | method printString ];
			matchSubstring
]

{ #category : #'*GT-Spotter' }
CompiledMethod >> spotterForSendersFor: aStep [
	<spotterOrder: 10>
	aStep listProcessor
			title: 'Senders';
			allCandidates: [ self senders collect: #compiledMethod ];
			itemName: [ :method | method printString ];
			matchSubstring
]

{ #category : #'*GT-Spotter' }
CompiledMethod >> spotterItemsFor: aStep [
	"do nothing for compiled method"
]
