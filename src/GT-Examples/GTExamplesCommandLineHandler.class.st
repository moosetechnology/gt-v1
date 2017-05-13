Class {
	#name : #GTExamplesCommandLineHandler,
	#superclass : #CommandLineHandler,
	#category : #'GT-Examples-Testing'
}

{ #category : #accessing }
GTExamplesCommandLineHandler class >> commandName [
	^ 'examples'
]

{ #category : #accessing }
GTExamplesCommandLineHandler class >> description [
	^ 'A command line example runner'
]

{ #category : #activation }
GTExamplesCommandLineHandler >> activate [
	self activateHelp
		ifTrue: [  ^ self ].
	self runPackages.
]

{ #category : #accessing }
GTExamplesCommandLineHandler >> addPackagesMatching: aString to: aSet [
	| regex |
	
	[ regex := aString asRegex ] 
		on: Error do: [ ].
	regex ifNotNil: [ ^ self addPackagesMatchingRegex: regex to: aSet ].
	
	(aString includes: $*)
		ifTrue: [ ^ self addPackagesMatchingGlob: aString to: aSet ].
	
	"exact match, and just those who actually have classes inside (to avoid 
	 super-package duplications)"
	((RPackage organizer includesPackageNamed: aString) 
		and: [ (RPackage organizer packageNamed: aString) definedClasses notEmpty ])
		ifTrue: [ aSet add: aString ]
]

{ #category : #accessing }
GTExamplesCommandLineHandler >> addPackagesMatchingGlob: aGlobString to: aSet [
	RPackage organizer packageNames do: [ :packageName|
		(aGlobString match: packageName)
			ifTrue: [ aSet add: packageName ]]
]

{ #category : #accessing }
GTExamplesCommandLineHandler >> addPackagesMatchingRegex: aRegex to: aSet [
	RPackage organizer packageNames do: [ :packageName|
		(aRegex matches: packageName)
			ifTrue: [ aSet add: packageName ]]
]

{ #category : #private }
GTExamplesCommandLineHandler >> exampleReport [
	(self hasOption: 'junit-xml-output') ifTrue: [ ^ GTExamplesHDReport ].
	^ self error: 'only works for now for junit for now'
]

{ #category : #private }
GTExamplesCommandLineHandler >> inform: aString [
	self stdout 
		<< aString
		<< OSPlatform current lineEnding
]

{ #category : #private }
GTExamplesCommandLineHandler >> informResults: results [
	self stdout 
		<< ('{1} run, {2} passes, {3} failures, {4} errors.'
			format: {
				results sum: #suiteTotal.
				results sum: #suitePassing.
				results sum: #suiteFailures.
				results sum: #suiteErrors })
		<< OSPlatform current lineEnding
]

{ #category : #accessing }
GTExamplesCommandLineHandler >> packages [
	| packages |
	packages := Set new.
	self arguments 
		reject: [ :arg| arg beginsWith: '-']
		thenDo: [ :arg| self addPackagesMatching: arg to: packages ].
	^ packages
]

{ #category : #private }
GTExamplesCommandLineHandler >> runPackages [
	| packages results |
	
	packages := self packages.
	self inform: 'Running examples in ', packages size asString, ' packages'.
	results := (self exampleReport runPackages: self packages) select: #notNil.
				
	self informResults: results.
	(self hasOption: 'save') ifTrue: [ Smalltalk saveSession ].
	((self hasOption: 'fail-on-failure') 
		and: [ results anySatisfy: #hasFailuresOrErrors ])
		ifTrue: [^ self exitFailure: 'Tests do not pass!' ].
	((self hasOption: 'fail-on-error') 
		and: [ results anySatisfy: #hasErrors ])
		ifTrue: [^ self exitFailure: 'Tests do not pass!' ].
	
	Smalltalk snapshot: false andQuit: true.
]
