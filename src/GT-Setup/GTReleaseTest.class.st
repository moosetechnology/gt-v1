Class {
	#name : #GTReleaseTest,
	#superclass : #TestCase,
	#category : #'GT-Setup'
}

{ #category : #accessing }
GTReleaseTest >> allClassesWithCustomExtensions [

	^ self allClassesWithSpotterExtensions asSet, self allClassesWithInspectorExtensions asSet
]

{ #category : #accessing }
GTReleaseTest >> allClassesWithInspectorExtensions [

	^ Object withAllSubclasses select: [ :eachClass |
		 (Pragma 
				allNamed: #gtInspectorPresentationOrder: 
				from: eachClass 
				to: eachClass) notEmpty ]
]

{ #category : #accessing }
GTReleaseTest >> allClassesWithSpotterExtensions [

	^ Object withAllSubclasses select: [ :eachClass |
		 (Pragma 
				allNamed: #spotterOrder: 
				from: eachClass 
				to: eachClass) notEmpty ]
]

{ #category : #tests }
GTReleaseTest >> hasExampleMethod: aClass [

	^ ((Pragma 
		allNamed: #example 
		from: aClass class
		to: aClass class),
	(Pragma 
		allNamed: #example: 
		from: aClass class
		to: aClass class)) notEmpty
		
]

{ #category : #tests }
GTReleaseTest >> testAllClassesWithCustomExtensionsHaveAnExample [
	| classesWithCustomExtensionsAndNoExample |
	
	classesWithCustomExtensionsAndNoExample := self allClassesWithCustomExtensions select: [ :aClass |
		(self hasExampleMethod: aClass) not ].
	
	self 
		assert: classesWithCustomExtensionsAndNoExample isEmpty
		description: [ String streamContents: [ :s|
			s 
				nextPutAll: 'Found classes with custom examples and no extension methods: ';
				print: classesWithCustomExtensionsAndNoExample ]].
]
