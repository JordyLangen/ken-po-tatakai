using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Azure.Documents;
using Microsoft.Azure.Documents.Client;

namespace Kenpotatakai.Core.Cosmos
{
    public interface IRepository<in TEntity>
    {
        Task EnsureCollectionExists();

        Task<ResourceResponse<Document>> Create(TEntity entity);
    }
}
