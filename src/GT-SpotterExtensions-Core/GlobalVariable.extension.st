Extension { #name : #GlobalVariable }

{ #category : #'*GT-SpotterExtensions-Core' }
GlobalVariable >> spotterActDefault [
	self value inspect
]

{ #category : #'*GT-SpotterExtensions-Core' }
GlobalVariable >> spotterClassFor: aStep [
	<spotterOrder: 50>
	aStep listProcessor
			title: 'Class';
			allCandidates: [ { self value class }];
			itemIcon: #systemIcon;
			filterUsing: GTFilterSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
GlobalVariable >> spotterReferenceFor: aStep [
	<spotterOrder: 130>
	aStep listProcessor
			title: 'References';
			allCandidates: [ (SystemNavigation default allReferencesTo: self) collect: #compiledMethod ];
			itemName: [ :method | method gtDisplayString ];
			filterUsing: GTFilterSubstring
]
