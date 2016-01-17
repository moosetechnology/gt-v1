Class {
	#name : #GTGenericStackDebuggerUITest,
	#superclass : #GLMMorphicTest,
	#category : #'GT-Tests-Debugger'
}

{ #category : #'as yet unclassified' }
GTGenericStackDebuggerUITest >> testNoOverlappingCodeEditorKeyBindings [
	| context process codeEditor keymaps doubleKeymaps |
	context := [ 20 factorial ] asContext.
	process := Process
		forContext: context
		priority: Processor userInterruptPriority.
	window := GTGenericStackDebugger openOn: (process newDebugSessionNamed: 'test debugging' startedAt: context).
	codeEditor := self findSatisfying: [ :morph | 
		morph model isKindOf: GLMRubricSmalltalkTextModel ] in: window.
	keymaps := ((codeEditor kmDispatcher targets collect: #category)
			add: codeEditor kmDispatcher directKeymaps;
			yourself)
			flatCollect: [ :category | 
				category allEntries keymaps ].
	doubleKeymaps := (keymaps groupedBy: #shortcut) select: [ :each | each value size > 1 ].
	self assert: doubleKeymaps isEmpty
]
