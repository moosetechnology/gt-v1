Extension { #name : #GTSpotter }

{ #category : #'*GT-SpotterExtensions-Core-private' }
GTSpotter >> evaluateExpression: query on: stream processor: processor [
	| result candidates |
	candidates := OrderedCollection new.
	(Number selectors anySatisfy: [ :selector | 
		query includesSubstring: selector caseSensitive: true ]) ifFalse: [ ^ candidates ].
	result := [ Compiler evaluate: query ] on: Error do: [ ^ candidates ].
	stream addObject: result inProcessor: processor. 
	candidates add: result. 
	(result isFraction and: [ result isInteger not ]) ifTrue: [ 
		stream addObject: result asFloat inProcessor: processor.
		candidates add: result ].
	^ candidates
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> filterByQuery: originalQuery forReferencesComputedAs: fileReferencesBlock inProcessor: processor onStream: stream [
	| prefixMatchers split rootDirectory query fullQuery rest |
	fullQuery := originalQuery trimBoth asLowercase.
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
		(all first: (all size min: 5)) do: [:reference | stream addObject: reference inProcessor: processor].
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
						prefixMatchers size > 5
							ifFalse: [ stream addObject: reference inProcessor: processor ] ]
					ifFalse: [ rest add: reference ] ] ].
	prefixMatchers size < 5
		ifTrue: [ (rest first: (5 - prefixMatchers size min: rest size)) do: [ :each | stream addObject: each inProcessor: processor ] ].
	^ prefixMatchers , rest
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterConcreteMethodFor: aStep [
    <spotterOrder: 30>
	| processor |
	processor := aStep listProcessor.
	processor
		title: 'Method';
		filter: [ :originalQuery :stream |
			| method result |
			result := OrderedCollection new.
			[
				Transcript show: originalQuery trimBoth; cr.
				method := Compiler evaluate: originalQuery trimBoth.
				method class = CompiledMethod ifTrue: [
					stream addObject: method inProcessor: processor.
					result add: method ] 
			] on: Error do: [  ].
			result ];
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterDirtyMonticelloPackagesFor: aStep [
	<spotterOrder: 85>
	aStep listProcessor
			allCandidates: [ MCWorkingCopy allManagers select: #modified ];
			title: 'Dirty Monticello packages';
			itemIcon: [ Smalltalk ui icons iconNamed: #dirtyPackageIcon ];
			filterUsing: GTFilterSubstring;
			wantsToDisplayOnEmptyQuery: true
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterForClassesFor: aStep [
	<spotterOrder: 10>
	aStep listProcessor
			allCandidates: [ Smalltalk allClassesAndTraits ];
			title: 'Classes';
			filterUsing: GTFilterSubstring;
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
		filter: [ :originalQuery :stream | 
					self
						filterByQuery: originalQuery
						forReferencesComputedAs: [ :root | root directories ]
						inProcessor: processor
						onStream: stream ]
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterForExpressionsFor: aStep [
	<spotterOrder: 1>
	| processor |
	(processor := aStep listProcessor)
		title: 'Calculator';
		filter: [ :query :stream | 
			self evaluateExpression: query on: stream processor: processor ];
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
		filter: [ :originalQuery :stream | 
					self
						filterByQuery: originalQuery
						forReferencesComputedAs: [ :root | root files ]
						inProcessor: processor
						onStream: stream ]
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
			filterUsing: GTFilterSubstring;
			wantsToDisplayOnEmptyQuery: false
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterForMetacelloConfigurationsFor: aStep [
	<spotterOrder: 21>
	aStep listProcessor
			title: 'Metacello configurations';
			allCandidates: [ 
				Smalltalk allClasses select: [ :each | 
					(each respondsTo: #isMetacelloConfig) 
						and: [ each isMetacelloConfig
							and: [ each name beginsWith: 'ConfigurationOf' ] ] ]
					thenCollect: #project ];
			itemName: [ :each | each configuration class name ];
			itemIcon: #systemIcon;
			filterUsing: GTFilterSubstring;
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
			filterUsing: GTFilterSubstring;
			wantsToDisplayOnEmptyQuery: false
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterForPlaygroundPagesFor: aStep [
	<spotterOrder: 100>
	aStep listProcessor
			allCandidates: [ GTPlayBook instance pages ];
			title: 'Playground';
			itemName: [ :page | page content asString contractTo: 100 ];
			filterUsing: GTFilterSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterForPragmasFor: aStep [
	<spotterOrder: 40>
	aStep listProcessor 
			allCandidates: [:x | PragmaType all ];
			title: 'Pragmas';
			itemName: [ :pragma | pragma keyword ];
			filterUsing: GTFilterSubstring;
			wantsToDisplayOnEmptyQuery: false
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterForRepositoriesFor: aStep [
	<spotterOrder: 22>
	aStep listProcessor
		title: 'Monticello Repositories';
		allCandidates: [ MCRepositoryGroup default repositories ];
		itemIcon: #systemIcon;
		wantsToDisplayOnEmptyQuery: false;
		filterUsing: GTFilterSubstring
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
		filterUsing: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterHistoryFor: aStep [
	<spotterOrder: 8>
	aStep listProcessor
			allCandidates: [:x | self class history select: [ :each | each isNotNil ] ];
			title: 'History';
			itemName: [ :item | item processor itemNameFor: item value ];
			filterUsing: GTFilterSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterImplementorsFor: aStep [
	<spotterOrder: 30>
	| processor |
	processor := aStep listProcessor.
	processor
		title: 'Implementors';
		filter: [ :originalQuery :stream | 
					GTImplementorsSpotter new
						query: originalQuery;
						stream: stream;
						processor: processor;
						behaviors: SystemNavigation default allBehaviors;
						find ]
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterStfxFor: aStep [
	<spotterOrder: 30>
	| processor |
	processor := aStep listProcessor.
	processor 
		title: 'ws.stfx.eu';
		filter: [ :originalQuery :stream |
			| aCollection query |
			aCollection := OrderedCollection  new.
			query := originalQuery trimBoth.
			(query beginsWith: 'http://ws.stfx.eu') ifTrue: [ 
				[| string page |
				string := GTUrlProvider new get: query.
				page := GTPlayPage new content: string.
				stream addObject: page inProcessor: processor.
				aCollection add: page] on: Error do: [ "nothing" ] ].
			aCollection ].
	^ processor
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterWorldMenuFor: aStep [
	<spotterOrder: 9>
	^ (World worldMenu spotterItemsFor: aStep)
		title: 'Menu'
]
