using System;
using System.Collections.Generic;
using System.Linq;
// https://www.nuget.org/packages/Microsoft.TeamFoundationServer.Client/
using Microsoft.TeamFoundation.WorkItemTracking.WebApi;
using Microsoft.TeamFoundation.WorkItemTracking.WebApi.Models;

//https://www.nuget.org/packages/Microsoft.TeamFoundationServer.Client/14.89.0
using Microsoft.TeamFoundation.Client;

// https://www.nuget.org/packages/Microsoft.VisualStudio.Services.InteractiveClient/
using Microsoft.VisualStudio.Services.Client;

// https://www.nuget.org/packages/Microsoft.VisualStudio.Services.Client/
using Microsoft.VisualStudio.Services.Common;

using Microsoft.TeamFoundation.Framework.Client;
using Microsoft.TeamFoundation.Framework.Common;

namespace CodeManProject
{
    public class TFSHelper
    {

        public string TFSURL { get; set; }
        public string TFSProject { get; set; }
        public List<WorkItem> getWorkItems()
        {
            // Create a connection object, which we will use to get httpclient objects.  This is more robust
            // then newing up httpclient objects directly.  Be sure to send in the full collection uri.
            // For example:  http://myserver:8080/tfs/defaultcollection
            VssCredentials vsCred = new VssCredentials(true);
            VssConnection connection = new VssConnection(new Uri(TFSURL), vsCred);

            // Create instance of WorkItemTrackingHttpClient using VssConnection
            WorkItemTrackingHttpClient witClient = connection.GetClient<WorkItemTrackingHttpClient>();

            List<WorkItem> resultWorkItem = new List<WorkItem>();

            try
            { 
                // Get 2 levels of query hierarchy items
                List<QueryHierarchyItem> queryHierarchyItems = witClient.GetQueriesAsync(TFSProject, depth: 0).Result;

                // Search for 'My Queries' folder
                QueryHierarchyItem myQueriesFolder = queryHierarchyItems.FirstOrDefault(qhi => qhi.Name.Equals("My Queries"));
                resultWorkItem = new List<WorkItem>();
                string queryStr = "SELECT [System.Id],[System.WorkItemType],[System.Title],[System.AssignedTo],[System.State],[System.Tags] FROM WorkItems WHERE [System.State] = 'New'";
                Wiql wiql = new Wiql();
                wiql.Query = queryStr;

                
                

                WorkItemQueryResult result = witClient.QueryByWiqlAsync(wiql).Result;
                //witClient.GetQueryAsync(TFSProject, queryStr).Result;
                if (result.WorkItems.Any())
                {
                    int skip = 0;
                    const int batchSize = 100;
                    IEnumerable<WorkItemReference> workItemRefs;
                    do
                    {
                        workItemRefs = result.WorkItems.Skip(skip).Take(batchSize);
                        if (workItemRefs.Any())
                        {
                            // get details for each work item in the batch
                            List<WorkItem> workItems = witClient.GetWorkItemsAsync(workItemRefs.Select(wir => wir.Id)).Result;
                            foreach (WorkItem workItem in workItems)
                            {
                                // write work item to console
                                resultWorkItem.Add(workItem);
                            }
                        }
                        skip += batchSize;
                    }
                    while (workItemRefs.Count() == batchSize);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            return resultWorkItem;
        }

        public List<String> getUsers()
        {
            string groupName = String.Format(@"%1\Contributors", TFSProject);
            List<string> userList = new List<string>();

            TfsTeamProjectCollection tfs = new TfsTeamProjectCollection(new Uri(TFSURL));
            tfs.EnsureAuthenticated();
            IIdentityManagementService ims = tfs.GetService<IIdentityManagementService>();

            TeamFoundationIdentity rootIdentity = ims.ReadIdentity(IdentitySearchFactor.AccountName, groupName, MembershipQuery.Direct, ReadIdentityOptions.None);

            DisplayGroupTree(ims, rootIdentity, 0, userList);

            return userList;
        }

        private static void DisplayGroupTree(IIdentityManagementService ims, TeamFoundationIdentity node, int level, List<string> usrLst)
        {
            DisplayNode(node, level, usrLst);

            if (!node.IsContainer)
                return;

            TeamFoundationIdentity[] nodeMembers = ims.ReadIdentities(node.Members, MembershipQuery.Direct,
                ReadIdentityOptions.None);

            int newLevel = level + 1;
            foreach (TeamFoundationIdentity member in nodeMembers)
                DisplayGroupTree(ims, member, newLevel, usrLst);
        }

        private static void DisplayNode(TeamFoundationIdentity node, int level, List<string> usrLst)
        {
            for (int tabCount = 0; tabCount < level; tabCount++)

                usrLst.Add(node.DisplayName);
        }
    }
}