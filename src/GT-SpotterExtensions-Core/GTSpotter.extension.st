Extension { #name : #GTSpotter }

{ #category : #'*GT-SpotterExtensions-Core-private' }
GTSpotter >> concreteMethodsInContext: aContext [
	" return the concrete methods described by the expression (Class >> #Selector) - evaluate it savely "
	| methods classAndSelectorStrings class selector |
	methods := OrderedCollection new.
	classAndSelectorStrings := (aContext textTrimmed splitOn: '>>') collect: [ :each | each trimBoth ].
	" check preconditions "
	classAndSelectorStrings size = 2 ifFalse: [ ^ methods ].
	classAndSelectorStrings second size < 2 ifTrue: [ ^ methods ].
	classAndSelectorStrings second first = $# ifFalse: [ ^ methods ].
	" retrieve concrete class and selector "
	(class := Smalltalk classNamed: classAndSelectorStrings first) ifNil: [ ^ methods ].
	selector := classAndSelectorStrings second allButFirst asSymbol.
	" retrieve the compiled method in the class and class hierarchy "
	class withAllSuperclassesDo: [ :aClass |
		([ aClass compiledMethodAt: selector ] on: Error do: [ nil ]) 
			ifNotNilDo: [ :compiledMethod | 
				aContext addItem: compiledMethod.
				methods add: compiledMethod ] ].
	^ methods
]

{ #category : #'*GT-SpotterExtensions-Core-private' }
GTSpotter >> evaluateExpressionInContext: aSpotterContext [
	" only allow arithmethic selectors to be evaluated - otherwise this may have some severe side-effects "
	| result candidates |
	candidates := OrderedCollection new.
	" filter allowed selectors "
	(Number withAllSubclasses anySatisfy: [ :class |
		class selectors anySatisfy: [ :selector | 
			aSpotterContext textTrimmed includesSubstring: selector caseSensitive: true ] ]) ifFalse: [ ^ candidates ].
	" perform the selector "
	result := [ Compiler evaluate: aSpotterContext textTrimmed ] 
		on: Error 
		do: [ ^ candidates ].
	result isNumber ifFalse: [ ^ candidates ].
	aSpotterContext addItem: result.
	candidates add: result. 
	" if the result is not readable as float, append the float as well "
	(result isFraction and: [ result isInteger not ]) ifTrue: [
		aSpotterContext addItem: result asFloat.
		candidates add: result ].
	^ candidates
]

{ #category : #'*GT-SpotterExtensions-Core-private' }
GTSpotter >> filterInContext: aSpotterContext forReferencesComputedAs: fileReferencesBlock [
	| prefixMatchers split rootDirectory query fullQuery rest |
	fullQuery := aSpotterContext textLowercase.
	split := fullQuery piecesCutWhere: [ :a :b | a = FileSystem disk delimiter ].
	split size < 1
		ifTrue: [ 
			query := fullQuery.
			rootDirectory := FileSystem workingDirectory ]
		ifFalse: [ 
			(split last last = FileSystem disk delimiter)
				ifTrue: [ 
					query := ''.
					rootDirectory := fullQuery asFileReference ]
				ifFalse: [ 
					query := split last.
					rootDirectory := ('' join: split allButLast) asFileReference ] ].
	rootDirectory exists ifFalse: [ ^ OrderedCollection new ].
	query isEmpty ifTrue: [ 
		| all |
		all := fileReferencesBlock value: rootDirectory.
		(all first: (all size min: aSpotterContext itemsLimit)) do: [:reference | aSpotterContext addItem: reference ].
		^ all  ].
	prefixMatchers := OrderedCollection new.
	rest := OrderedCollection new.
	(fileReferencesBlock value: rootDirectory) do: [ :reference | 
			| index |
			index := reference basename findString: query startingAt: 1 caseSensitive: false.
			index >= 1 ifTrue: [ 
				index = 1 
					ifTrue: [ 
						prefixMatchers add: reference.
						prefixMatchers size > aSpotterContext itemsLimit
							ifFalse: [ aSpotterContext addItem: reference ] ]
					ifFalse: [ rest add: reference ] ] ].
	prefixMatchers size < aSpotterContext itemsLimit
		ifTrue: [ (rest first: (aSpotterContext itemsLimit - prefixMatchers size min: rest size)) do: [ :each | aSpotterContext addItem: each ] ].
	^ prefixMatchers , rest
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterConcreteMethodFor: aStep [
    <spotterOrder: 30>
	^ aStep listProcessor
		title: 'Method';
		filter: [ :context | self concreteMethodsInContext: context ];
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterDirtyMonticelloPackagesFor: aStep [
	<spotterOrder: 85>
	aStep listProcessor
			allCandidates: [ MCWorkingCopy allManagers select: #modified ];
			title: 'Dirty Monticello packages';
			itemIcon: [ Smalltalk ui icons iconNamed: #dirtyPackageIcon ];
			filter: GTFilterSubstring;
			wantsToDisplayOnEmptyQuery: true
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterForClassesFor: aStep [
	<spotterOrder: 10>
	aStep listProcessor
			allCandidates: [ Smalltalk allClassesAndTraits ];
			title: 'Classes';
			filter: GTFilterSubstring;
			itemIcon: #systemIcon;
			wantsToDisplayOnEmptyQuery: false
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterForDirectoriesFor: aStep [
	<spotterOrder: 50>
	| processor |
	processor := aStep listProcessor.
	processor
		title: 'Directories';
		itemIcon: [ GLMUIThemeExtraIcons glamorousFolder ];
		wantsToDisplayOnEmptyQuery: false;
		filter: [ :context | 
			self
				filterInContext: context
				forReferencesComputedAs: [ :root | root directories ] ]
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterForExpressionsFor: aStep [
	<spotterOrder: 1>
	| processor |
	(processor := aStep listProcessor)
		title: 'Calculator';
		filter: [ :context | self evaluateExpressionInContext: context ];
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterForFilesFor: aStep [
	<spotterOrder: 40>
	| processor |
	processor := aStep listProcessor.
	processor
		title: 'Files';
		itemIcon: [ GLMUIThemeExtraIcons glamorousBrowse ];
		wantsToDisplayOnEmptyQuery: false;
		filter: [ :context | 
			self
				filterInContext: context
				forReferencesComputedAs: [ :root | root files ] ]
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterForGlobalVarsFor: aStep [
	<spotterOrder: 40>
	aStep listProcessor
			allCandidates: [ Smalltalk globals associations select:[:assoc | 
			assoc value isBehavior not and:[ 
				assoc value isTrait not]] ];
			title: 'Global variables';
			itemName:[:global | global key ];
			filter: GTFilterSubstring;
			wantsToDisplayOnEmptyQuery: false
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterForMetacelloConfigurationsFor: aStep [
	<spotterOrder: 86>
	aStep listProcessor
			title: 'Metacello Configurations';
			allCandidates: [ 
				Smalltalk allClasses select: [ :each | 
					(each respondsTo: #isMetacelloConfig) 
						and: [ each isMetacelloConfig
							and: [ each name beginsWith: 'ConfigurationOf' ] ] ]
					thenCollect: #project ];
			itemName: [ :each | each configuration class name ];
			itemIcon: [ Smalltalk ui icons iconNamed: #configIcon ];
			filter: GTFilterSubstring;
			wantsToDisplayOnEmptyQuery: false
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterForPackagesFor: aStep [
	<spotterOrder: 20>
	aStep listProcessor
			allCandidates: [ RPackageOrganizer default packages ];
			title: 'Packages';
			itemName: [ :package | package name ];
			itemIcon: [ Smalltalk ui icons iconNamed: #packageIcon ];
			filter: GTFilterSubstring;
			wantsToDisplayOnEmptyQuery: false
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterForPlaygroundPagesFor: aStep [
	<spotterOrder: 100>
	aStep listProcessor
			allCandidates: [ GTPlayBook instance pages ];
			title: 'Playground';
			itemName: [ :page | page content asString contractTo: 100 ];
			filter: GTFilterSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterForPragmasFor: aStep [
	<spotterOrder: 40>
	aStep listProcessor 
			allCandidates: [:x | PragmaType all ];
			title: 'Pragmas';
			itemName: [ :pragma | pragma keyword ];
			filter: GTFilterSubstring;
			wantsToDisplayOnEmptyQuery: false
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterForRepositoriesFor: aStep [
	<spotterOrder: 87>
	aStep listProcessor
		title: 'Monticello Repositories';
		allCandidates: [ MCRepositoryGroup default repositories ];
		itemIcon: #systemIcon;
		wantsToDisplayOnEmptyQuery: false;
		filter: GTFilterSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterForTestClassesFor: aStep [
	<demoOnly: 'NautilusUI - this is a very ugly implementaiton - just for demo'>
	<spotterOrder: 20>
	aStep listProcessor
		title: 'Tests';
		allCandidates: [ TestCase allSubclasses ];
		itemName: [ :item | item name ];
		itemIcon: #systemIcon;
		actLogic: [ :item | NautilusUI new runTestsOfClass: item notifying: true ];
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterHistoryFor: aStep [
	<spotterOrder: 8>
	aStep listProcessor
			allCandidates: [:x | self class history asArray select: [ :each | each isNotNil and: [ each value isNotNil ] ] ];
			title: 'History';
			itemName: [ :item | 
				item class = GTSpotterProcessorLink 
					ifTrue: [ item processor itemNameFor: item value ] " HACK: this triggers a recursion ! ... but processor is undefined for aCandidate "
					ifFalse: [ item gtDisplayString ] ];
			filter: GTFilterSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterImplementorsFor: aStep [
	<spotterOrder: 30>
	aStep listProcessor
		title: 'Implementors';
		filter: [ :context | 
			GTImplementorsSpotter new
				context: context;
				behaviors: SystemNavigation default allBehaviors;
				find ]
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterStfxFor: aStep [
	<spotterOrder: 30>
	^ aStep listProcessor
		title: 'ws.stfx.eu';
		filter: [ :context |
			| aCollection query |
			aCollection := OrderedCollection  new.
			query := context textTrimmed.
			(query beginsWith: 'http://ws.stfx.eu') ifTrue: [ 
				[| string page |
				string := GTUrlProvider new get: query.
				page := GTPlayPage new content: string.
				context addItem: page.
				aCollection add: page] on: Error do: [ "nothing" ] ].
			aCollection ]
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterWorldMenuFor: aStep [
	<spotterOrder: 9>
	^ (World worldMenu spotterItemsFor: aStep)
		title: 'Menu'
]
