Class {
	#name : #GTReleaseTest,
	#superclass : #TestCase,
	#category : #'GT-Tests-Release'
}

{ #category : #private }
GTReleaseTest >> assertIncludesPackages: includedPackageNames excludedPackages: excludedPackageNames ignoredClasses: ignoredClasses pragmas: pragmas examples: examples description: aString [
	| packages missingExamples missingExamplesWithoutIgnoredClasses obsoleteIgnoredClasses |
	
	" gather all packages that should be checked "
	packages := self includesPackages: includedPackageNames excludedPackages: excludedPackageNames.
	
	" check the given packages and filter out some classes "
	missingExamples := self packages: packages pragmas: pragmas examples: examples.
	missingExamplesWithoutIgnoredClasses := self missingExamples: missingExamples withoutIgnoredClasses: ignoredClasses.
	
	" check for missing examples - ignore some classes "
	self assert: missingExamplesWithoutIgnoredClasses isEmpty 
		description: [ 
			String streamContents: [ :stream |
				stream nextPutAll: (aString ifNil: [ 'Found missing examples in' ]); nextPutAll: ': '.
				(missingExamplesWithoutIgnoredClasses keys sorted: [ :a :b | a name < b name ]) printOn: stream ] ].
	
	" check for ignored examples which are provided - those should no longer be ignored "
	self assert: (obsoleteIgnoredClasses := ignoredClasses difference: missingExamples keys) isEmpty 
		description: [ 
			String streamContents: [ :stream |
				stream nextPutAll: 'Examples found. Test should no longer ignore these classes: '.
				(obsoleteIgnoredClasses sorted: [ :a :b | a name < b name ]) printOn: stream ] ]
]

{ #category : #private }
GTReleaseTest >> includesPackages: includedPackageNames excludedPackages: excludedPackageNames [
	| packages |
	packages := OrderedCollection new.
	(RPackageOrganizer default packages 
		sorted: [ :a :b | a packageName < b packageName ]) 
		do: [ :package |
			((includedPackageNames isEmptyOrNil
				or: [ includedPackageNames anySatisfy: [ :packageName | package packageName asLowercase beginsWith: packageName asLowercase ] ])
					and: [ excludedPackageNames isEmptyOrNil
						or: [ excludedPackageNames noneSatisfy: [ :packageName | package packageName asLowercase beginsWith: packageName asLowercase ] ] ])
							ifTrue: [ packages add: package ] ].
	^ packages
]

{ #category : #private }
GTReleaseTest >> missingExamples: missingExamples withoutIgnoredClasses: classes [
	| missingExamplesWithoutIgnoredClasses |
	classes isEmptyOrNil ifTrue: [ ^ missingExamples ].
	missingExamplesWithoutIgnoredClasses := missingExamples copy.
	classes do: [ :class | missingExamplesWithoutIgnoredClasses removeKey: class ifAbsent: [  ] ].
	^ missingExamplesWithoutIgnoredClasses
]

{ #category : #private }
GTReleaseTest >> packages: packages pragmas: pragmasRequiringExamples examples: examplePragmas [
	| missingExamples |
	missingExamples := Dictionary new.
	packages do: [ :package |
		package classes do: [ :class |
			class theNonMetaClass = class ifTrue: [ " we are only interested in classes "
				| methodsRequiringExamples |
				methodsRequiringExamples := pragmasRequiringExamples flatCollect: [ :each | Pragma allNamed: each in: class ].
				methodsRequiringExamples ifNotEmpty: [ " example required "
					| exampleMethods |
					exampleMethods := examplePragmas flatCollect: [ :each | Pragma allNamed: each in: class theMetaClass ].
					exampleMethods ifEmpty: [ " something is missing - check which package would require the example "
						(methodsRequiringExamples anySatisfy: [ :pragma | (packages includes: pragma method package) ]) ifTrue: [ 
							missingExamples 
								at: class 
								put: (methodsRequiringExamples collect: [ :pragma | pragma method ]) ] ] ] ] ] ].
	^ missingExamples
]

{ #category : #tests }
GTReleaseTest >> testAllMissingExternalExamples [
	self assertIncludesPackages: nil
		excludedPackages: { 'Glamour-'. 'GT-'. 'Moose-'. }
		ignoredClasses: { 
			Slot. " abstract "
		}
		pragmas: #( #spotterOrder: #gtInspectorPresentationOrder: )
		examples: #( #gtExample #gtExample: )
		description: 'All missing external examples'
]

{ #category : #tests }
GTReleaseTest >> testAllMissingInternalExamples [
	self assertIncludesPackages: { 'Glamour-'. 'GT-'. 'Moose-'. }
		excludedPackages: nil
		ignoredClasses: {
			ComposableModel. " abstract superclass "	
			GTSpotterExceptionMock1. " counter-example "
			GTSpotterExceptionMock2. " counter-example "
			GTSpotterExceptionMock3. " counter-example "
			GTSpotterExceptionMock4. " counter-example "
			GTSpotterExceptionMock5. " counter-example "
			RTAbstractExample.  " abstract factory for collecting examples "
			Slot. " abstract "
			TClass. " spotter/processor tests would be ulimatively slow "
			ZnMessage. " abstract factory & superclass / subclasses provide examples "
		}
		pragmas: #( #spotterOrder: #gtInspectorPresentationOrder: )
		examples: #( #gtExample #gtExample: )
		description: 'All missing internal examples'
]

{ #category : #tests }
GTReleaseTest >> testMissingGTInspectorExamples [
	self assertIncludesPackages: { 'GT-Inspector' }
		excludedPackages: nil
		ignoredClasses: {
			ComposableModel. " abstract superclass "
			RTAbstractExample.  " abstract factory for collecting examples "
			TClass. " spotter/processor tests would be ulimatively slow "
			ZnMessage. " abstract factory & superclass / subclasses provide examples "
		}
		pragmas: #( #gtInspectorPresentationOrder: )
		examples: #( #gtExample #gtExample: )
		description: 'Missing examples for GTInspector'
]

{ #category : #tests }
GTReleaseTest >> testMissingGTSpotterExamples [
	self assertIncludesPackages: { 'GT-Spotter' }
		excludedPackages: nil
		ignoredClasses: { 
			Slot. " abstract "
			TClass. " spotter/processor tests would be ulimatively slow "
		}
		pragmas: #( #spotterOrder: )
		examples: #( #gtExample #gtExample: )
		description: 'Missing examples for GTSpotter'
]

{ #category : #tests }
GTReleaseTest >> testMissingTests [
	self flag: 'maybe enhance the following abstract classes (generic extension may work for most/all subclasses). Most/all subclasses would be examples. Intermediate classes are not tagged as abstract - not distinguishable - #allSubclasses doesn^t work. Announcer. Canvas. ComposableModel OCAbstractScope. RTView. TRCanvas. IRInstruction. Slot. Slot/Inspector is buggy'.
	self flag: 'find a solution to provide examples for TClass + MooseModel but still have usable tests / examples in both classes will slow down tests tremendously'
]