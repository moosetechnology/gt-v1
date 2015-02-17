Extension { #name : #TestCase }

{ #category : #'*GT-SpotterExtensions-Core' }
TestCase class >> spotterForSuiteFor: aStep [
	<spotterOrder: 1>
	aStep listProcessor
			allCandidates: [ Array with: self suite ];
			title: 'Suites';
			itemName: [ :item | item name ];
			itemIcon: #systemIcon;
			actLogic: [ :item | 
				" this is an ugly implementaiton - just to demo it "
				NautilusUI new runTestsOfSuite: item notifying: true ];
			matchSubstring;
			wantsToDisplayOnEmptyQuery: true
]

{ #category : #'*GT-SpotterExtensions-Core' }
TestCase class >> spotterForSuitesFor: aStep [
	<spotterOrder: 1>
	aStep listProcessor
			allCandidates: [ self testSelectors collect: [ :each | 
					(self buildSuiteFromMethods: { each }) name: each; yourself ] ];
			title: 'Testcases';
			itemName: [ :item | item name ];
			itemIcon: #systemIcon;
			actLogic: [ :item | 
				" this is an ugly implementaiton - just to demo it "
				NautilusUI new runTestsOfSuite: item notifying: true ];
			matchSubstring;
			wantsToDisplayOnEmptyQuery: true
]
