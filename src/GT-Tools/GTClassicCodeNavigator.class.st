"
self openOn: Smalltalk organization .
"
Class {
	#name : #GTClassicCodeNavigator,
	#superclass : #GLMGlobalBrowserTemplate,
	#category : #'GT-Tools'
}

{ #category : #'as yet unclassified' }
GTClassicCodeNavigator >> buildBrowser [
	browser := GLMTabulator new.
	browser
		column: #classCats;
		column: #classes;
		column: #categories;
		column: #methods.
	browser
		showOn: #classCats;
		using: 
			[ browser list 
				display: #categories;
				updateOn: AbstractEvent from: GTSystemAnnouncer categoryAnnouncer ].
	browser
		showOn: #classes;
		from: #classCats;
		using: [
			browser tree
				shouldValidate: true;
				display: [ :classCat | 
					(Smalltalk organization listAtCategoryNamed: classCat) 
						collect: [ :className | Smalltalk classNamed: className ] ];
				children: [ :each | each traitComposition traits ];
				updateOn: AbstractEvent from: GTSystemAnnouncer classAnnouncer;
				title: 'Class list'.
			browser mondrian 
				painting: [ :view :package |
					view nodes: ((Smalltalk organization listAtCategoryNamed: package) collect: [:name | Smalltalk classNamed: name]).
					view edgesFrom: #superclass.
					view treeLayout.];
				updateOn: AbstractEvent from: GTSystemAnnouncer classAnnouncer;
				title: 'Hierarchy'.
 ].
	browser
		showOn: #categories;
		from: #classes;
		using: [ 
			browser list 
				updateOn: AbstractEvent from: GTSystemAnnouncer protocolAnnouncer;
				display: [ :class | class organization categories ] ].
	browser 
		showOn: #methods;
		from: #classes;
		from: #categories;
		using: 
			[ browser list
				updateOn: AbstractEvent from: GTSystemAnnouncer methodAnnouncer;
				display: 
					[ :class :category | 
					(class organization listAtCategoryNamed: category) asSortedCollection].
			browser list
				useExplicitNotNil;
				updateOn: AbstractEvent from: GTSystemAnnouncer methodAnnouncer;
				when: [ :class :category | class notNil and: [ category isNil ] ];
				display: [ :class :category | class selectors asSortedCollection ] ].
	browser 
		sendToOutside: #selectedClassCategory
		from: #classCats.
	browser 
		sendToOutside: #selectedClass
		from: #classes.
	browser 
		sendToOutside: #selectedMethod
		from: #methods.
	"for updating selection from lintBrowser"
	"browser 
		sendTo: #methods -> #selection
		fromOutside: #faultyMethod."
	^ browser
]
