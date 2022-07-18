using AutoMapper.QueryableExtensions;
using CarServiceBackend.Database;
using CarServiceBackend.Database.Models;
using Microsoft.EntityFrameworkCore;

namespace CarServiceBackend.Repository
{
    public class WorkRepository
    {
        private readonly CarServiceContext _carContext;
        private readonly AutoMapper.IConfigurationProvider _mapperConfig;

        public WorkRepository(CarServiceContext carContext, AutoMapper.IConfigurationProvider mapperConfig)
        {
            _carContext = carContext;
            _mapperConfig = mapperConfig;
        }

        public async Task<Work> Add(Work work)
        {
            _carContext.Works.Add(work);
            await _carContext.SaveChangesAsync();
            return work;
        }

        public async Task<Work> Update(Work work)
        {
            _carContext.Works.Update(work);
            await _carContext.SaveChangesAsync();
            return work;
        }

        public async Task<List<T>> GetAll<T>()
        {
            return await _carContext
                .Works
                .ProjectTo<T>(_mapperConfig)
                .ToListAsync();
        }

        public async Task<IEnumerable<Work>> GetAll()
        {
            return await _carContext
                .Works
                .ToListAsync();
        }

        public IQueryable<Work> GetQuery()
        {
            return _carContext.Works;
        }
    }
}
