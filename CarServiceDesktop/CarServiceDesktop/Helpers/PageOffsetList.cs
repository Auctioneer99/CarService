using System.Collections.Generic;

namespace CarServiceDesktop.Helpers
{
    public class PageOffsetList : System.ComponentModel.IListSource
    {
        public bool ContainsListCollection { get; protected set; }

        public int TotalRecords { get; set; }

        public int PageSize { get; set; }

        public PageOffsetList()
        {

        }

        public System.Collections.IList GetList()
        {
            var pageOffsets = new List<int>();
            for (int offset = 0; offset < TotalRecords; offset += PageSize)
            {
                pageOffsets.Add(offset);
            }
            return pageOffsets;
        }
    }
}
