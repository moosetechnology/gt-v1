Class {
	#name : #GTSpotterProcessorsForExamplesTest,
	#superclass : #TestCase,
	#category : #'GT-Tests-Examples'
}

{ #category : #running }
GTSpotterProcessorsForExamplesTest >> setUp [
	super setUp.
	
	GTExampleOrganizer reset; stop
]

{ #category : #running }
GTSpotterProcessorsForExamplesTest >> tearDown [
	super tearDown.
	
	GTExampleOrganizer reset; start
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
						raise: Error ] ]  ]
		displayingProgress: 'Testing GTSpotter examples (#testEachProcessor)'
]
