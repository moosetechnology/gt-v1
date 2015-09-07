Class {
	#name : #GTSpotterProcessorsForExamplesTest,
	#superclass : #TestCase,
	#category : #'GT-Tests-Spotter'
}

{ #category : #tests }
GTSpotterProcessorsForExamplesTest >> testEachProcessor [
	<todo: 'fix the #gtExamples for the finder'>
	(Object withAllSubclasses difference: GTExampleFinder withAllSubclasses) 
		do: [ :eachClass |
			eachClass gtExamples do: [ :exampleToTest |
				self 
					shouldnt: [
						| step |
						(step := GTSpotterStep new)
							spotter: (GTSpotter new
								exceptionHandler: GTSpotterDebuggingExceptionHandler new; " we want to know whether one of the processors is raising an exception "
								yourself);
							origin: exampleToTest result;
							processContext: (step newContextForQuery: 'a') ] 
					raise: Error ] ]
		displayingProgress: 'Testing GTSpotter examples (#testEachProcessor)'
]
