Extension { #name : #RTView }

{ #category : #'*GT-SpotterExtensions-CoreRoassal' }
RTView classSide >> gtExampleEmptyView [
	<gtExample: 'Empty View'>
	^ self new
]

{ #category : #'*GT-SpotterExtensions-CoreRoassal' }
RTView classSide >> gtExampleViewAtRandom [
	<gtExample: 'Random Roassal View'>
	^ RTAbstractExample allSubclasses atRandom new gtExamples atRandom
]

{ #category : #'*GT-SpotterExtensions-CoreRoassal' }
RTView >> spotterElementsFor: aStep [
	<spotterOrder: 10>
	^ aStep listProcessor
		title: 'Elements';
		candidatesLimit: 100;
		allCandidates: [ self elements ];
		itemName: [ :each | each model gtDisplayString ];
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]
