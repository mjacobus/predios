export const selectIndexes = (indexes, collection) => {
  return collection.filter((value, index) => indexes.indexOf(index) >= 0);
};

export const removeItem = (item, collection) => {
  return collection.filter(value => item !== value);
};

export const duplicate = collection => Object.assign([], collection);
