Extension { #name : #GTSpotter }

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterDirtyMonticelloPackagesFor: aStep [
	<spotterOrder: 80>
	aStep listProcessor
			allCandidates: [ MCWorkingCopy allManagers select: #modified ];
			title: 'Dirty Monticello packages';
			itemIcon: [ Smalltalk ui icons iconNamed: #dirtyPackageIcon ];
			matchSubstring;
			wantsToDisplayOnEmptyQuery: true
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterForClassesFor: aStep [
	<spotterOrder: 10>
	aStep listProcessor
			allCandidates: [ Smalltalk allClasses ];
			title: 'Classes';
			matchSubstring;
			itemIcon: #systemIcon;
			wantsToDisplayOnEmptyQuery: false
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterForDirectoriesFor: aStep [
	<spotterOrder: 50>
	(FileSystem workingDirectory 
		spotterForDirectoriesFor: aStep)
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterForFilesFor: aStep [
	<spotterOrder: 40>
	(FileSystem workingDirectory spotterForFilesFor: aStep)
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
			matchSubstring;
			wantsToDisplayOnEmptyQuery: false
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterForPlaygroundPagesFor: aStep [
	<spotterOrder: 100>
	aStep listProcessor
			allCandidates: [ GTPlayBook instance pages ];
			title: 'Playground';
			itemName: [ :page | page content asString contractTo: 100 ];
			matchSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterForPragmasFor: aStep [
	<spotterOrder: 40>
	aStep listProcessor
			allCandidates: [:x | PragmaType all ];
			title: 'Pragmas';
			itemName: [ :pragma | pragma keyword ];
			matchSubstring;
			wantsToDisplayOnEmptyQuery: false
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterHistoryFor: aStep [
	<spotterOrder: 0>
	aStep listProcessor
			allCandidates: [:x | self class history select: [ :each | each isNotNil ] ];
			title: 'History';
			matchSubstring;
			wantsToDisplayOnEmptyQuery: true
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTSpotter >> spotterImplementorsFor: aStep [
	<spotterOrder: 30>
	| processor |
	processor := aStep listProcessor.
	processor 
		title: 'Implementors';
		filter: [ :originalQuery :stream |
				| aCollection query |
				aCollection := OrderedCollection  new.
				query := originalQuery trimBoth.
				SystemNavigation default allBehaviorsDo: [:class | 
					(class includesSelector: query asSymbol)
						ifTrue: [
							| method |
							method := class>>(query asSymbol).
							aCollection add: method.
							aCollection size > 5 ifFalse: [ 
								stream addObject: method inProcessor: processor ]]].
				aCollection ].
	^ processor
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
	<spotterOrder: 90>
	^ (World worldMenu spotterItemsFor: aStep)
		title: 'Menu'
]
