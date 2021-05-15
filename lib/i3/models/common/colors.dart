class Colors {
  String background;
  String statusline;
  String separator;
  String focusedBackground;
  String focusedStatusline;
  String focusedSeparator;
  String focusedWorkspaceBorder;
  String focusedWorkspaceBg;
  String focusedWorkspaceText;
  String inactiveWorkspaceBorder;
  String inactiveWorkspaceBg;
  String inactiveWorkspaceText;
  String activeWorkspaceBorder;
  String activeWorkspaceBg;
  String activeWorkspaceText;
  String urgentWorkspaceBorder;
  String urgentWorkspaceBg;
  String urgentWorkspaceText;
  String bindingModeBorder;
  String bindingModeBg;
  String bindingModeText;

  Colors(
      {this.background,
      this.statusline,
      this.separator,
      this.focusedBackground,
      this.focusedStatusline,
      this.focusedSeparator,
      this.focusedWorkspaceBorder,
      this.focusedWorkspaceBg,
      this.focusedWorkspaceText,
      this.inactiveWorkspaceBorder,
      this.inactiveWorkspaceBg,
      this.inactiveWorkspaceText,
      this.activeWorkspaceBorder,
      this.activeWorkspaceBg,
      this.activeWorkspaceText,
      this.urgentWorkspaceBorder,
      this.urgentWorkspaceBg,
      this.urgentWorkspaceText,
      this.bindingModeBorder,
      this.bindingModeBg,
      this.bindingModeText});

  Colors.fromJson(Map<String, dynamic> json) {
    background = json['background'];
    statusline = json['statusline'];
    separator = json['separator'];
    focusedBackground = json['focused_background'];
    focusedStatusline = json['focused_statusline'];
    focusedSeparator = json['focused_separator'];
    focusedWorkspaceBorder = json['focused_workspace_border'];
    focusedWorkspaceBg = json['focused_workspace_bg'];
    focusedWorkspaceText = json['focused_workspace_text'];
    inactiveWorkspaceBorder = json['inactive_workspace_border'];
    inactiveWorkspaceBg = json['inactive_workspace_bg'];
    inactiveWorkspaceText = json['inactive_workspace_text'];
    activeWorkspaceBorder = json['active_workspace_border'];
    activeWorkspaceBg = json['active_workspace_bg'];
    activeWorkspaceText = json['active_workspace_text'];
    urgentWorkspaceBorder = json['urgent_workspace_border'];
    urgentWorkspaceBg = json['urgent_workspace_bg'];
    urgentWorkspaceText = json['urgent_workspace_text'];
    bindingModeBorder = json['binding_mode_border'];
    bindingModeBg = json['binding_mode_bg'];
    bindingModeText = json['binding_mode_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['background'] = this.background;
    data['statusline'] = this.statusline;
    data['separator'] = this.separator;
    data['focused_background'] = this.focusedBackground;
    data['focused_statusline'] = this.focusedStatusline;
    data['focused_separator'] = this.focusedSeparator;
    data['focused_workspace_border'] = this.focusedWorkspaceBorder;
    data['focused_workspace_bg'] = this.focusedWorkspaceBg;
    data['focused_workspace_text'] = this.focusedWorkspaceText;
    data['inactive_workspace_border'] = this.inactiveWorkspaceBorder;
    data['inactive_workspace_bg'] = this.inactiveWorkspaceBg;
    data['inactive_workspace_text'] = this.inactiveWorkspaceText;
    data['active_workspace_border'] = this.activeWorkspaceBorder;
    data['active_workspace_bg'] = this.activeWorkspaceBg;
    data['active_workspace_text'] = this.activeWorkspaceText;
    data['urgent_workspace_border'] = this.urgentWorkspaceBorder;
    data['urgent_workspace_bg'] = this.urgentWorkspaceBg;
    data['urgent_workspace_text'] = this.urgentWorkspaceText;
    data['binding_mode_border'] = this.bindingModeBorder;
    data['binding_mode_bg'] = this.bindingModeBg;
    data['binding_mode_text'] = this.bindingModeText;
    return data;
  }
}
