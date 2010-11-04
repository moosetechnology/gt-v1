"
self openOn: Smalltalk organization.
"
Class {
	#name : #GTClassicCodeBrowser,
	#superclass : #GLMGlobalBrowserTemplate,
	#classInstVars : [
		'announcer'
	],
	#category : #'GT-Tools'
}

{ #category : #building }
GTClassicCodeBrowser >> buildBrowser [
	browser := GLMTabulator new.
	browser
		row: #navigation;
		row: #sourceCode.
	browser
		showOn: #navigation;
		using: [ browser custom: GTClassicCodeNavigator new browser ].
	(browser transmit)
		to: #sourceCode;
		from: #navigation port: #selectedClass;
		from: #navigation port: #selectedMethod;
		from: #navigation port: #selectedClassCategory;
		andShow: [ :a | self sourceCodeIn: a ].
		"for updating selection through lintBrowser"
		"browser sendTo: #navigator->#faultyMethod from: #source->#faultyMethod."
	^ browser
]

{ #category : #building }
GTClassicCodeBrowser >> sourceCodeIn: a [
	| lintBrowser |
	(a text)
		title: 'Method source';
		display: [ :class :method | class sourceCodeAt: method ];
		forSmalltalk: [ :class | class ].
	(a text)
		forSmalltalk;
		useExplicitNotNil;
		title: 'Class definition';
		display: [ :class | class definition ];
		when: [ :class | class notNil ].
	(a text)
		title: 'Class comment';
		display: [ :class | class comment ];
		useExplicitNotNil;
		when: [ :class | class notNil ].
	lintBrowser := GTLintBrowser new browser.
	lintBrowser
		allowNil;
		when: [ :clas :mth | clas notNil ].
	^ a custom: lintBrowser
]
