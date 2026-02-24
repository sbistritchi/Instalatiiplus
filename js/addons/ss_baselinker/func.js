function fn_ss_bl_jsCopyClipboard(param, title, message) {
    // Copy the text inside the text field
    navigator.clipboard.writeText(param);
    $.ceNotification('show', {
        type: 'N',
        title: title,
        message: message,
        message_state: 'I'
    });
}