"
This is a simple browser showing a list of classes and their methods. It is meant to be used inside other browsers.

self openOn: Collection withAllSubclasses
"
Class {
	#name : #GTSimpleClassesMethodsBrowser,
	#superclass : #GLMBrowserTemplate,
	#category : #'GT-Tools-Utils'
}

{ #category : #building }
GTSimpleClassesMethodsBrowser >> buildBrowser [
	browser := GLMTabulator new.
	browser column: #classes; column: #methods.
	browser showOn: #classes; using: [
		browser list
			display: [:classes | classes asOrderedCollection sorted: [:a :b | a name < b name] ]].
	browser showOn: #methods; from: #classes; using: [
		browser list
			display: [:cls | cls selectors asOrderedCollection sorted: [:a :b | a < b]]].
	browser sendToOutside: #selectedClass from: #classes.
	browser sendToOutside: #selectedMethod from: #methods.
	^ browser
]
