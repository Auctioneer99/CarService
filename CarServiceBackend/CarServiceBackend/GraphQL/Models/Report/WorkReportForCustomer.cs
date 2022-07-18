namespace CarServiceBackend.GraphQL.Models.Report
{
    public class WorkReportForCustomer
    {
        public double Price { get; set; }

        public int Count { get; set; }

        public WorkReportForCustomer(double price, int count)
        {
            Price = price;
            Count = count;
        }
    }
}
