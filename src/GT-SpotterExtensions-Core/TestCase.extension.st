Extension { #name : #TestCase }

{ #category : #'*GT-SpotterExtensions-Core' }
TestCase class >> spotterForSuiteFor: aStep [
	<spotterOrder: 1>
	aStep listProcessor
		title: 'Tests';
		allCandidates: [ Array with: self suite ];
		itemName: [ :item | item name ];
		itemIcon: [ :item | GTTestRunner iconForClass: self ];
		actLogic: [ :item | GTTestRunner runTestsForSuite: item ];
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #'*GT-SpotterExtensions-Core' }
TestCase class >> spotterForSuitesFor: aStep [
	<spotterOrder: 1>
	aStep listProcessor
		title: 'Testcases';
		allCandidates: [ self testSelectors collect: [ :each | self selector: each ] ];
		itemName: [ :item | item name ];
		itemIcon: [ :item | GTTestRunner iconForTestCase: item ];
		actLogic: [ :item | GTTestRunner runTestForTestCase: item ];
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]
