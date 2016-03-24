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
	obsoleteIgnoredClasses := (ignoredClasses difference: missingExamples keys) reject: [ :each | each isNil ].
	self assert: obsoleteIgnoredClasses isEmpty 
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
	<toBeDeprecated: #gtExample:>
	self assertIncludesPackages: nil
		excludedPackages: { 'Glamour-'. 'GT-'. 'Moose-'. 'Petit'. 'Renraku'. 'Slot'. 'Opal'. 'Roassal' }
		ignoredClasses: {
			Behavior. "Has abstract methods"
			TraitBehavior. "Has abstract methods"
			TBehavior. }
		pragmas: #( #spotterOrder: #gtInspectorPresentationOrder: )
		examples: #( #gtExample #gtExample: )
		description: 'All missing external examples'
]

{ #category : #tests }
GTReleaseTest >> testAllMissingInternalExamples [
	<toBeDeprecated: #gtExample:>
	self assertIncludesPackages: { 'Glamour-'. 'GT-'. 'Moose-'. }
		excludedPackages: nil
		ignoredClasses: {
			AbstractMorphicAdapter. 
			ComposableModel. 
			GTEventCollectors. 
			GTEventRecorder. 
			GTExampleProxy. " dummy "
			GTSpotterExceptionMock1. " mock "
			GTSpotterExceptionMock2. " mock "
			GTSpotterExceptionMock3. " mock "
			GTSpotterExceptionMock4. " mock "
			GTSpotterExceptionMock5. " mock "
			MetacelloVersionLoadDirective. " corrupt package detection "
			MorphicTreeNodeAdapter. " corrupt package detection "
			Slot. " corrupt package detection "
			TClass. " corrupt package detection "
			TClassDescription. " corrupt package detection "
			ZnMessage. " corrupt package detection "
			TBehavior. 
		}
		pragmas: #( #spotterOrder: #gtInspectorPresentationOrder: )
		examples: #( #gtExample #gtExample: )
		description: 'All missing internal examples'
]

{ #category : #tests }
GTReleaseTest >> testMissingGTInspectorExamples [
	<toBeDeprecated: #gtExample:>
	self assertIncludesPackages: { 'GT-Inspector' }
		excludedPackages: nil
		ignoredClasses: {
			AbstractMorphicAdapter. " corrupt package detection "
			"BlMorph" " corrupt package detection "
			"GTExample" " makes no sense "
			GTExampleProxy. " makes no sense "
			ComposableModel. " abstract superclass "
			MetacelloVersionLoadDirective. " corrupt package detection "
			MorphicTreeNodeAdapter. " corrupt package detection "
			TClass. " spotter/processor tests would be ulimatively slow "
			TClassDescription.
			ZnMessage. " abstract factory & superclass / subclasses provide examples "
		}
		pragmas: #( #gtInspectorPresentationOrder: )
		examples: #( #gtExample #gtExample: )
		description: 'Missing examples for GTInspector'
]

{ #category : #tests }
GTReleaseTest >> testMissingGTSpotterExamples [
	<toBeDeprecated: #gtExample:>
	self assertIncludesPackages: { 'GT-Spotter' }
		excludedPackages: nil
		ignoredClasses: { 
			Slot. " abstract "
			TClass. " spotter/processor tests would be ulimatively slow "
			TClassDescription.
			TBehavior. 
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
