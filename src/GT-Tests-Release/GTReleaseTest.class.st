Class {
	#name : #GTReleaseTest,
	#superclass : #TestCase,
	#category : #'GT-Tests-Release'
}

{ #category : #accessing }
GTReleaseTest >> allClassesWithCustomExtensions [

	^ (self allClassesWithPragma: #spotterOrder:) asSet , 
	(self allClassesWithPragma: #gtInspectorPresentationOrder:) 
]

{ #category : #accessing }
GTReleaseTest >> allClassesWithPragma: pragmaSymbol [
	^ Object withAllSubclasses
		select: [ :eachClass | 
			"we reject the meta classes because they do not need examples"
			eachClass = eachClass theNonMetaClass and: [
				(Pragma allNamed: pragmaSymbol from: eachClass to: eachClass) notEmpty ] ]
]

{ #category : #tests }
GTReleaseTest >> hasExampleMethod: aClass [

	^ ((Pragma 
		allNamed: #gtExample 
		from: aClass class
		to: aClass class),
	(Pragma 
		allNamed: #gtExample: 
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
				nextPutAll: 'Found classes with custom extensions and no example methods: ';
				print: classesWithCustomExtensionsAndNoExample ]].
]
