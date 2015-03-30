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
GTSpotter >> evaluateExpressionInContext: aSpotterContext usingFilter: filter [
	" only allow arithmethic selectors to be evaluated - otherwise this may have some severe side-effects "
	| result |
	" filter allowed selectors "
	(Number withAllSubclasses anySatisfy: [ :class |
		class selectors anySatisfy: [ :selector | 
			aSpotterContext textTrimmed includesSubstring: selector caseSensitive: true ] ]) ifFalse: [ ^ self ].
	" perform the selector "
	Smalltalk compiler 
		silentlyDo: [ result := Smalltalk compiler evaluate: aSpotterContext textTrimmed ] 
		exceptionDo: [ ^ self ].
	result isNumber ifFalse: [ ^ self ].
	filter value: result. 
	" if the result is not readable as float, append the float as well "
	(result isFraction and: [ result isInteger not ]) ifTrue: [
		filter value: result asFloat ]
]

{ #category : #'*GT-SpotterExtensions-Core-private' }
GTSpotter >> fileReferencesBy: aSelector inContext: aSpotterContext usingFilter: aBlock [
	| split rootDirectory query |
	split := aSpotterContext textLowercase piecesCutWhere: [ :a :b | a = FileSystem disk delimiter ].
	split size < 1
		ifTrue: [ 
			query := aSpotterContext textLowercase.
			rootDirectory := FileSystem workingDirectory ]
		ifFalse: [ 
			(split last last = FileSystem disk delimiter)
				ifTrue: [ 
					query := ''.
					rootDirectory := aSpotterContext textLowercase asFileReference ]
				ifFalse: [ 
					query := split last.
					rootDirectory := ('' join: split allButLast) asFileReference ] ].
	rootDirectory exists ifFalse: [ ^ self ].
	" hack: see senders of #queryForFileReference "
	aSpotterContext cacheAt: #queryForFileReference put: query.
	(rootDirectory perform: aSelector) do: aBlock
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterClipboardFor: aStep [
	<spotterOrder: 90>
	^ aStep listProcessor
		title: 'Clipboard History';
		items: [ Clipboard default recentItems ];
		itemName: [ :item | item asString contractTo: 100 ];
		itemFilterName: [ :item | item asString ];
		filter: GTFilterSubstrings;
		actLogic: [ :item | item asString inspect ];
		wantsToDisplayOnEmptyQuery: false
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
	self flag: #specialFilter.
	aStep listProcessor
		title: 'Directories';
		itemIcon: [ GLMUIThemeExtraIcons glamorousFolder ];
		itemFilterName: [ :reference | reference basename ];
		filter: GTFilterFileReference item: [ :filter :context | 
			self fileReferencesBy: #directories inContext: context usingFilter: filter ];
		wantsToDisplayOnEmptyQuery: false	
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterForExpressionsFor: aStep [
	<spotterOrder: 1>
	self flag: #specialFilter.
	aStep listProcessor
		title: 'Calculator';
		filter: GTNullFilter item: [ :filter :context | 
			self evaluateExpressionInContext: context usingFilter: filter ];
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterForFilesFor: aStep [
	<spotterOrder: 40>
	self flag: #specialFilter.
	aStep listProcessor
		title: 'Files';
		itemIcon: [ GLMUIThemeExtraIcons glamorousBrowse ];
		itemFilterName: [ :reference | reference basename ];
		filter: GTFilterFileReference item: [ :filter :context | 
			self fileReferencesBy: #files inContext: context usingFilter: filter ];
		wantsToDisplayOnEmptyQuery: false
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
GTSpotter >> spotterForHelpTopicFor: aStep [
	<spotterOrder: 200>
	aStep listProcessor 
			allCandidates: [ SystemHelp asHelpTopic gtAllSubtopics ];
			title: 'Help topics';
			itemName: [ :helpTopic | helpTopic title ];
			itemIcon: [ :helpTopic | helpTopic gtTopicIcon ];
			matchSubstrings;
			wantsToDisplayOnEmptyQuery: true
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
			allCandidates: [ GTPlayBook instance pagesSorted ];
			title: 'Playground';
			itemName: [ :page | page content asString contractTo: 100 ];
			filter: GTFilterSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterForPragmasFor: aStep [
	<spotterOrder: 40>
	aStep listProcessor 
			allCandidates: [ PragmaType all ];
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
GTSpotter >> spotterForSettingsFor: aStep [
	<spotterOrder: 100>
	aStep listProcessor
		title: 'Settings';
		allCandidates: [ (SettingTree new acceptableKeywords: SettingBrowser settingsKeywords) nodeList ];
		itemName: [ :each | each spotterLabel ];
		filter: GTFilterSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterHistoryFor: aStep [
	<spotterOrder: 8>
	aStep listProcessor
			allCandidates: [ self class history asArray select: [ :each | each isNotNil and: [ each value isNotNil ] ] ];
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
	self flag: #specialFilter.
	aStep listProcessor
		title: 'Implementors';
		itemFilterName: [ :method | method selector asString ];	
		filter: GTFilterSubstring item: [ :filter :context | 
			SystemNavigation default allBehaviorsDo: [ :class | class methodsDo: filter ] ]
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterStfxFor: aStep [
	<spotterOrder: 30>
	self flag: #specialFilter.
	^ aStep listProcessor
		title: 'ws.stfx.eu';
		filter: GTNullFilter item: [ :filter :context | 
			(context textTrimmed beginsWith: 'http://ws.stfx.eu')
				ifTrue: [ GTPlayPage loadFromPublishUrl: context textTrimmed thenDo: filter ] ]
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterWorldMenuFor: aStep [
	<spotterOrder: 9>
	^ (World worldMenu spotterItemsFor: aStep)
		title: 'Menu'
]
