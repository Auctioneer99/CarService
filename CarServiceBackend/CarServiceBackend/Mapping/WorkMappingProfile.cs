using AutoMapper;
using CarServiceBackend.Database.Models;
using CarServiceBackend.GraphQL.Models.Work;

namespace CarServiceBackend.Mapping
{
    public class WorkMappingProfile : Profile
    {
        public WorkMappingProfile()
        {
            CreateMap<WorkAddView, Work>();
        }
    }
}
