using System;

namespace CarServiceDesktop.Models.Work
{
    public class WorkView
    {
        public int Id { get; set; }
        public string Number { get; set; }

        public string Task { get; set; }

        public double Price { get; set; }

        public double Mileage { get; set; }

        public DateTime PerformDate { get; set; }

        public DateTime? ReturnDate { get; set; }

        public override bool Equals(object obj)
        {
            if (obj is WorkView other)
            {
                return Id.Equals(other.Id) &&
                    Number.Equals(other.Number) &&
                    Task.Equals(other.Task) &&
                    Price.Equals(other.Price) &&
                    Mileage.Equals(other.Mileage) &&
                    PerformDate.Equals(other.ReturnDate) &&
                    ReturnDate.Equals(other.ReturnDate);
            }
            return base.Equals(obj);
        }
    }
}
