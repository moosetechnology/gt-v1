Class {
	#name : #GTReleaseTest,
	#superclass : #TestCase,
	#category : #'GT-Tests-Release'
}

{ #category : #accessing }
GTReleaseTest >> allClassesWithCustomExtensions [

	^ self pragmasForCustomExtensions asSet flatCollect: [ :pragma | 
		self allClassesWithPragma: pragma ]
]

{ #category : #accessing }
GTReleaseTest >> allClassesWithPragma: pragmaSymbol [
	^ Object withAllSubclasses
		select: [ :eachClass | 
			"we reject the meta classes because they do not need examples"
			eachClass = eachClass theNonMetaClass and: [
				(Pragma allNamed: pragmaSymbol from: eachClass to: eachClass) notEmpty ] ]
]

{ #category : #testing }
GTReleaseTest >> hasExampleMethod: aClass [

	^ self pragmasForExamples anySatisfy: [ :pragma | 
		(Pragma 
			allNamed: pragma
			from: aClass class
			to: aClass class) notEmpty ]
]

{ #category : #accessing }
GTReleaseTest >> pragmasForCustomExtensions [
	^ #( #spotterOrder: #gtInspectorPresentationOrder: )
]

{ #category : #accessing }
GTReleaseTest >> pragmasForExamples [
	^ #( #gtExample #gtExample: )
]

{ #category : #testing }
GTReleaseTest >> shouldIgnoreExampleMethod: aClass [
	self flag: 'TODO: how to proceed with special cases of examples? still implement them ? in which package ? we should only iterate over examples which actually belong to the namespace of GT. We shouldnt handle <missing> examples in outside packages. This exception list is temporary only'.
	^ #(
		GTSpotterExceptionMock1 " GTSpotterExceptionMock* are special extensions only used for testing faulty conditions/examples. They should be ignored in this test. "
		GTSpotterExceptionMock2 
		GTSpotterExceptionMock3 
		GTSpotterExceptionMock4 
		GTSpotterExceptionMock5
		LiteralVariable  " OpalTools "
		IRInstruction  " OpalTools "
		IRMethod  " OpalTools "
		IRSequence  " OpalTools "
		LiteralValue  " OpalTools "
		OCAbstractScope 	" OpalTools "
		PPFailure " PetitGui "
		PPParser " PetitGui "
		PPParserDebuggerResult " PetitGui "
		ReflectiveMethod " Reflectivity (model!?) "
		SymbolicBytecode " OpalTools (model!?) "
	 ) anySatisfy: [ :each | each = aClass name ]
]

{ #category : #tests }
GTReleaseTest >> testAllClassesWithCustomExtensionsHaveAnExample [
	| classesWithCustomExtensionsAndNoExample |
	
	classesWithCustomExtensionsAndNoExample := self allClassesWithCustomExtensions select: [ :aClass |
		(self hasExampleMethod: aClass) not
			and: [ (self shouldIgnoreExampleMethod: aClass) not ] ].
	
	self 
		assert: classesWithCustomExtensionsAndNoExample isEmpty
		description: [ String streamContents: [ :s|
			s 
				nextPutAll: 'Found classes with custom extensions and no example methods: ';
				print: classesWithCustomExtensionsAndNoExample ]].
]
