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
		ignoredClasses: { " abstract -> " Slot }
		pragmas: #( #spotterOrder: #gtInspectorPresentationOrder: )
		examples: #( #gtExample #gtExample: )
		description: 'All missing external examples'
]

{ #category : #tests }
GTReleaseTest >> testAllMissingInternalExamples [
	self assertIncludesPackages: { 'Glamour-'. 'GT-'. 'Moose-'. }
		excludedPackages: nil
		ignoredClasses: { " abstract -> " ComposableModel. RTAbstractExample. Slot. ZnMessage. " faulty test mocks -> " GTSpotterExceptionMock1. GTSpotterExceptionMock2. GTSpotterExceptionMock3. GTSpotterExceptionMock4. GTSpotterExceptionMock5. }
		pragmas: #( #spotterOrder: #gtInspectorPresentationOrder: )
		examples: #( #gtExample #gtExample: )
		description: 'All missing internal examples'
]

{ #category : #tests }
GTReleaseTest >> testMissingGTInspectorExamples [
	self assertIncludesPackages: { 'GT-Inspector' }
		excludedPackages: nil
		ignoredClasses: { " abstract -> " ComposableModel. RTAbstractExample. ZnMessage  }
		pragmas: #( #gtInspectorPresentationOrder: )
		examples: #( #gtExample #gtExample: )
		description: 'Missing examples for GTInspector'
]

{ #category : #tests }
GTReleaseTest >> testMissingGTSpotterExamples [
	self assertIncludesPackages: { 'GT-Spotter' }
		excludedPackages: nil
		ignoredClasses: { " abstract -> " Slot }
		pragmas: #( #spotterOrder: )
		examples: #( #gtExample #gtExample: )
		description: 'Missing examples for GTSpotter'
]
