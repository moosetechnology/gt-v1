Class {
	#name : #GTExampleMethodSubject,
	#superclass : #GTAbstractExampleMethod,
	#category : #'GT-Examples-Utils'
}

{ #category : #'accessing-dynamic' }
GTExampleMethodSubject >> asGTExampleSubject [
	^ self
]

{ #category : #ui }
GTExampleMethodSubject >> gtSpotterGTExamplesFor: aStep [
	<spotterOrder: 102>
	aStep listProcessor
		title: 'Examples with Subject ', self gtDisplayString;
		filter: GTNullFilter item: [ :filter :context | 
			GTExampleOrganizer instance examplesDo: [ :cn :s :example |
				(example hasSubject: self) ifTrue: [ filter value: example ] ] ];
		wantsToDisplayOnEmptyQuery: true
]
