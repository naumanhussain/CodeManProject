
<%@ Page Language="C#" AutoEventWireup="true" Inherits="Test" CodeFile="Test.aspx.cs"  %>

 



<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

<html xmlns='http://www.w3.org/1999/xhtml'>

<head runat="server">

    <title>Telerik ASP.NET Example</title>

</head>

<body>

    <form id="form1" runat="server">

    <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />

    <telerik:RadSkinManager ID="RadSkinManager1" runat="server"   ShowChooser="true" />

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">

        <AjaxSettings>

            <telerik:AjaxSetting AjaxControlID="RadScheduler1">

                <UpdatedControls>

                    <telerik:AjaxUpdatedControl ControlID="RadScheduler1" LoadingPanelID="RadAjaxLoadingPanel1">

                    </telerik:AjaxUpdatedControl>

                </UpdatedControls>

            </telerik:AjaxSetting>

        </AjaxSettings>

    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server">

    </telerik:RadAjaxLoadingPanel>

    <div class="demo-container no-bg">

        <telerik:RadScheduler RenderMode="Lightweight" runat="server" ID="RadScheduler1" DayStartTime="08:00:00" 

            DayEndTime="18:00:00" OnAppointmentInsert="RadScheduler1_AppointmentInsert" 
              AllowEdit ="false"   ExportSettings-OpenInNewWindow="true"
             OnAppointmentContextMenuItemClicked="RadScheduler1_AppointmentClick" ExportSettings-Pdf-PageTitle="test pdf"
             
            

            OnAppointmentUpdate="RadScheduler1_AppointmentUpdate" OnAppointmentDelete="RadScheduler1_AppointmentDelete" 
            OnAppointmentClick="RadScheduler1_AppointmentClick" 

            DataKeyField="ID" DataSubjectField="Subject" DataStartField="Start" DataEndField="End"

            DataRecurrenceField="RecurrenceRule" DataRecurrenceParentKeyField="RecurrenceParentId"

            DataReminderField="Reminder">

            <ExportSettings OpenInNewWindow="true" FileName="SchedulerExport">
    <Pdf 
        PageTitle="Schedule" 
        Author="Telerik"

        PaperSize="A5"
        PageLeftMargin="40mm"
        PageRightMargin="40mm"
        PageBottomMargin="40mm"
        PageTopMargin="40mm"

        Creator="Telerik" 
        Title="Schedule">
    </Pdf>                    
</ExportSettings>
</telerik:RadScheduler>



            <AdvancedForm Modal="true"></AdvancedForm>

            <TimelineView UserSelectable="false"></TimelineView>

            <TimeSlotContextMenuSettings EnableDefault="true"></TimeSlotContextMenuSettings>

            <AppointmentContextMenuSettings EnableDefault="true"></AppointmentContextMenuSettings>

            <Reminders Enabled="true"></Reminders>

        </telerik:RadScheduler>

    </div>

    </form>

</body>

</html>