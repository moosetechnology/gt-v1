Extension { #name : #Class }

{ #category : #'*GT-SpotterExtensions-Core' }
Class >> spotterActDefault [
	^ self browse
]

{ #category : #'*GT-SpotterExtensions-Core' }
Class >> spotterClassInstanceVariablesFor: aStep [
	<spotterOrder: 25>
	aStep listProcessor
			title: 'Class instance variables';
			allCandidates: [ self class layout allSlots ];
			itemName: [:each | each name asString];
			matchSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
Class >> spotterClassMethodsFor: aStep [
	<spotterOrder: 15>
	aStep listProcessor
			title: 'Class methods';
			allCandidates: [ self class methods ];
			itemName: [ :method | method selector ];
			matchSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
Class >> spotterInstanceVariablesFor: aStep [
	<spotterOrder: 20>
	aStep listProcessor
			title: 'Instance variables';
			allCandidates: [ self layout allSlots ];
			itemName: [:each | each name asString];
			matchSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
Class >> spotterMethodsFor: aStep [
	<spotterOrder: 10>
	aStep listProcessor
			title: 'Instance methods';
			allCandidates: [ self methods ];
			itemName: [ :method | method selector ];
			matchSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
Class >> spotterReferenceFor: aStep [
	<spotterOrder: 30>
	aStep listProcessor
			title: 'References';
			allCandidates: [ (SystemNavigation default allReferencesTo: self binding) collect: #compiledMethod ];
			itemName: [ :method | method gtDisplayString ];
			matchSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
Class >> spotterSubclassesFor: aStep [
	<spotterOrder: 50>
	aStep listProcessor
			title: 'All subclasses';
			allCandidates: [ self allSubclasses ];
			itemIcon: #systemIcon;
			matchSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
Class >> spotterSuperclassesFor: aStep [
	<spotterOrder: 40>
	aStep listProcessor
			title: 'All superclasses';
			allCandidates: [ self deepCollect: #superclass ];
			itemIcon: #systemIcon;
			matchSubstring
]
