using AutoMapper;
using CarServiceBackend.Database.Models;
using CarServiceBackend.GraphQL.Models.Transport;

namespace CarServiceBackend.Mapping
{
    public class TransportMappingProfile : Profile
    {
        public TransportMappingProfile()
        {
            CreateMap<TransportAddView, Transport>();
        }
    }
}
