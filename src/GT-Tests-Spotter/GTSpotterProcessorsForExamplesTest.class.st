Class {
	#name : #GTSpotterProcessorsForExamplesTest,
	#superclass : #TestCase,
	#category : #'GT-Tests-Spotter'
}

{ #category : #running }
GTSpotterProcessorsForExamplesTest >> setUp [
	super setUp.
	
	(Smalltalk classNamed: #GTExampleOrganizer) ifNotNil: [ :class | 
		class instance reset. 
		class stop ]
]

{ #category : #running }
GTSpotterProcessorsForExamplesTest >> tearDown [
	super tearDown.
	
	(Smalltalk classNamed: #GTExampleOrganizer) ifNotNil: [ :class | 
		class instance reset. 
		class start ]
]

{ #category : #tests }
GTSpotterProcessorsForExamplesTest >> testEachProcessor [
	Object withAllSubclasses
		do: [ :eachClass |
			eachClass gtExamples do: [ :exampleToTest |
				exampleToTest ignoreTest ifFalse: [ 
					self 
						shouldnt: [
							| step |
							(step := GTSpotterStep new)
								spotter: (GTSpotter new
									exceptionHandler: GTSpotterDebuggingExceptionHandler new; " we want to know whether one of the processors is raising an exception "
									yourself);
								origin: exampleToTest " do don't use #result here anymore, because it is not our responsibility to check whether an example runs sucessfully or not ";
								processContext: (step newContextForQuery: 'a') ] 
						raise: Error.
					exampleToTest detachResultFromSystem " just to be sure " ] ]  ]
		displayingProgress: 'Testing GTSpotter examples (#testEachProcessor)'
]
