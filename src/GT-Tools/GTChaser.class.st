"
self openOn: #buildBrowser
"
Class {
	#name : #GTChaser,
	#superclass : #GLMBrowserTemplate,
	#category : #'GT-Tools'
}

{ #category : #building }
GTChaser >> buildBrowser [
	"self openOn: #browser"
	browser := GLMFinder new.
	browser title: [:each | 'Chasing Browser of #', each].
	browser show: [:a |
		a custom: GTSimpleMethodsSourceBrowser new browser.
	].
	^ browser
]
