Class {
	#name : #GTSpotterProcessorsForExamplesTest,
	#superclass : #TestCase,
	#category : #'GT-Tests-Spotter'
}

{ #category : #tests }
GTSpotterProcessorsForExamplesTest >> testEachProcessor [
	Object withAllSubclassesDo: [ :eachClass |
		eachClass gtExamples do: [ :exampleToTest |
			self 
				shouldnt: [
					| step |
					(step := GTSpotterStep new)
						spotter: GTSpotter new;
						origin: exampleToTest result;
						relevantProcessorsProcess: (step newContextForQuery: 'a') ] 
				raise: Error ] ]
]
