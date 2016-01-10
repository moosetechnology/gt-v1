"
This is a specialized inspector that is embedded in  GTDebugger.

It is special in two ways:
- the first presentation is different in that it shows all variables active in the debugging context
- the looking up of presentation ignores the default state presentation because the vertical splitting of state and workspace does not work in the context of the debugger due to space limitations. Instead, the workspace is offered in a separate presentation.
"
Class {
	#name : #GTDebuggerInspector,
	#superclass : #GTInspector,
	#category : #'GT-Debugger-UI'
}

{ #category : #callbacks }
GTDebuggerInspector >> actOnPaneAdded: ann [

	self panes size > 1 ifTrue: [ 
		(self panes before: self panes last) presentations first updateToolbar ]
]

{ #category : #building }
GTDebuggerInspector >> attachExtraBehaviourToPresentationsIn: aComposite [

	aComposite presentations do: [ :aPresentation |
		aPresentation addAction: 
			((self closeActionFor: aPresentation)
				condition: [ :currentPresentation |
					self panes size > 1 and: [ 
						self panes last presentations first 
							cachedPresentation 
								ifNil: [ false ]
								ifNotNil: [ :aCachedPresentation |
									aCachedPresentation first 
										includes: currentPresentation ]  ] ] ) ]
]

{ #category : #building }
GTDebuggerInspector >> compose [
	self pager
		minimumPageNumberForScrollbar: 2; 
		show: [ :a :each | 
			a dynamic display: [ :x | 
				GLMCompositePresentation new with: [ :aComposite | 
					each gtDebuggerPresentationsIn: aComposite inContext: self.
					self attachExtraBehaviourToPresentationsIn: aComposite.
					aComposite ] ] ].
	self first when: GLMPaneAdded send: #actOnPaneAdded: to: self
]

{ #category : #actions }
GTDebuggerInspector >> removeLastPane [
	super removeLastPane.

	self first panes last presentations first updateToolbar
]

{ #category : #actions }
GTDebuggerInspector >> updateToolbarsIn: aPresentation [

	aPresentation
		withAllPanesAndPresentationsDo: [ :each | 
			(each isKindOf: GLMPresentation) ifTrue: [ each updateToolbar ] ]
]
