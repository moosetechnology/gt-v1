"
self openOn: Collection withAllSubclasses
"
Class {
	#name : #GTSimpleClassesBrowser,
	#superclass : #GLMBrowserTemplate,
	#category : #'GT-Tools'
}

{ #category : #'as yet unclassified' }
GTSimpleClassesBrowser >> buildBrowser [
	browser := GLMTabulator new.
	browser column: #classes; column: #methods.
	browser showOn: #classes; using: [
		browser list
			display: [:classes | classes asOrderedCollection sortBy: [:a :b | a name < b name] ]].
	browser showOn: #methods; from: #classes; using: [
		browser list
			display: [:cls | cls selectors asOrderedCollection sortBy: [:a :b | a < b]]].
	browser sendToOutside: #selectedClass from: #classes.
	browser sendToOutside: #selectedMethod from: #methods.
	^ browser
]
