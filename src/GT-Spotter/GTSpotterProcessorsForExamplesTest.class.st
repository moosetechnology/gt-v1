Class {
	#name : #GTSpotterProcessorsForExamplesTest,
	#superclass : #TestCase,
	#category : #'GT-Spotter-Tests'
}

{ #category : #tests }
GTSpotterProcessorsForExamplesTest >> testEachProcessor [
	Object withAllSubclassesDo: [ :eachClass |
		eachClass gtExamples do: [ :exampleToTest |
			self 
				shouldnt: [
					GTSpotterStep new 
						spotter: GTSpotter new;
						origin: exampleToTest result;
						relevantProcessorsProcess: 'a'] 
				raise: Error ] ]
]
