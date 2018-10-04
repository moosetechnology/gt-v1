Extension { #name : #CompiledMethod }

{ #category : #'*GT-Chatter' }
CompiledMethod >> gtInspectorActionChatAboutIt [
	<gtInspectorAction>
	^ self asFullRingDefinition gtInspectorActionChatAboutIt
]
