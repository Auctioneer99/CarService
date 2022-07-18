namespace CarServiceBackend.GraphQL.Models.Work
{
    public class WorkUpdateView
    {
        public long Id { get; set; }
        public DateTime? ReturnDate { get; set; }
        public double Price { get; set; }
        public double Mileage { get; set; }
        public string Task { get; set; } = null!;
    }
}
