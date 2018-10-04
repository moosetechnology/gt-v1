"
self openOn: HelpOnHelp asHelpTopic
"
Class {
	#name : #GTHelper,
	#superclass : #GLMBrowserTemplate,
	#category : #'GT-Tools'
}

{ #category : #building }
GTHelper >> buildBrowser [ 
	"self openOn: HelpOnHelp"
	browser := GLMTabulator new.
	browser title: 'Helper'.
	browser act: [:b | b update ] icon: GLMUIThemeExtraIcons glamorousRefresh entitled: 'Refresh'.
	browser column: #index; column: #contents span: 2.
	browser transmit to: #index; andShow: [:a |
		a tree 
			title: 'Index';
			display: #asHelpTopic;
			children: #subtopics;
			rootsExpanded;
			icon: #icon;
			format: #title ].
	browser transmit from: #index; to: #contents; andShow: [:a | 
		a text 
			title: 'Contents';
			display: #contents ].
	^ browser 
]
