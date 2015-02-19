Class {
	#name : #GTSpotterProcessorsForExamplesTest,
	#superclass : #TestCase,
	#category : #'GT-Spotter-Tests'
}

{ #category : #tests }
GTSpotterProcessorsForExamplesTest >> testEachProcessor [
	Object withAllSubclassesDo: [ :eachClass |
		Transcript cr; show: eachClass name; show: ': '.
		eachClass gtExamples do: [ :exampleToTest |
			Transcript tab; show: exampleToTest result printString; cr.
			self 
				shouldnt: [
					GTSpotterStep new 
						spotter: GTSpotter new;
						origin: exampleToTest result;
						relevantProcessorsProcess: 'a'] 
				raise: Error ] ]
]
