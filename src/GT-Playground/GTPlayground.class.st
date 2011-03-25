"
self open.


Playground is the correspondent of a classic Smalltalk Workspace. The problem with the name Workspace is that it implies that work should be carried out in this space, while this is not a best practice. Playground describes better the intention of providing a place in which we can quickly play with some code.


"
Class {
	#name : #GTPlayground,
	#superclass : #GLMGlobalBrowserTemplate,
	#category : #'GT-Playground'
}

{ #category : #building }
GTPlayground >> buildBrowser [
	browser := GLMAccumulator new.
	browser title: 'Playground'.
	browser act: [:b | b entity: GTPlaygroundPage new] icon: GLMUIThemeExtraIcons glamorousAdd entitled: 'Add'.
	browser show: [:a | 
		a title: [:page | page title].
		a text 
			forSmalltalk;
			display: [:page | page content ] ].
	^ browser
]

{ #category : #building }
GTPlayground >> entity [ 
	^ GTPlaygroundPage new content: ''; title: 'Page1'
]
