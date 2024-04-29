<template>
    <div class="h-screen w-full flex items-center justify-end">
        <Transition>
            <div v-show="ShowLoader" class="absolute h-full w-full flex items-center justify-center bg-[#1c2328] z-40">
                <div class="flex flex-col items-center gap-3">
                    <svg class="animate-spin h-8 w-8 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                        <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                    </svg>
                    <h1 class="text-white/80 font-medium">Karakterler Yükleniyor...</h1>
                </div>
            </div>
        </Transition>
        <Transition>
            <div v-show="ShowMulticharacter" class="h-[55%] w-[22rem] mr-24 p-6 flex flex-col justify-between rounded-2xl bg-[#1c2328]">
                <Transition mode="out-in">
                    <div v-if="Characters[SelectedSloth]" class="inline-grid gap-5">
                        <div class="flex items-center gap-4">
                            <div class="h-[6.5rem] w-[6.5rem] rounded-md bg-cover bg-[url(https://cdn.discordapp.com/attachments/643438558782291988/1199022536709652672/noneroleplaymultichar.png)]"></div>
                            <div>
                                <h1 class="text-white/80 font-medium">{{ Characters[SelectedSloth].charinfo.firstname }} {{ Characters[SelectedSloth].charinfo.lastname }}</h1>
                                <h1 class="text-sm text-white/40 italic">{{ Characters[SelectedSloth].job.label }}</h1>
                            </div>
                        </div>
                        <div class="grid grid-cols-2 gap-3">
                            <div>
                                <h1 class="text-xs text-white/40 italic">{{ Lang.gender }}</h1>
                                <p class="text-sm text-white/80">{{ Characters[SelectedSloth].charinfo.gender == 1 ? Lang.female : Lang.male }}</p>
                            </div>
                            <div>
                                <h1 class="text-xs text-white/40 italic">{{ Lang.birthday }}</h1>
                                <p class="text-sm text-white/80">{{ Characters[SelectedSloth].charinfo.birthdate }}</p>
                            </div>
                            <div>
                                <h1 class="text-xs text-white/40 italic">{{ Lang.money }}</h1>
                                <p class="text-sm text-white/80">{{ (() => {
                                    return new Intl.NumberFormat('en-US', {
                                        style: 'currency',
                                        currency: 'USD'
                                    }).format(Characters[SelectedSloth].money.cash+Characters[SelectedSloth].money.bank);
                                })() }}</p>
                            </div>
                            <div>
                                <h1 class="text-xs text-white/40 italic">{{ Lang.phone_number }}</h1>
                                <p class="text-sm text-white/80">{{ Characters[SelectedSloth].charinfo.phone }}</p>
                            </div>
                            <div>
                                <h1 class="text-xs text-white/40 italic">{{ Lang.grade }}</h1>
                                <p class="text-sm text-white/80">{{ Characters[SelectedSloth].job.grade.name }}</p>
                            </div>
                            <div>
                                <h1 class="text-xs text-white/40 italic">{{ Lang.nationality }}</h1>
                                <p class="text-sm text-white/80">{{ Characters[SelectedSloth].charinfo.nationality }}</p>
                            </div>
                        </div>
                        <div>
                            <h1 class="text-xs text-white/40 italic">{{ Lang.gangs }}</h1>
                            <p v-if="Characters[SelectedSloth].gang.name == 'none'" class="text-sm text-white/80">{{ Lang.not_gang }}</p>
                            <p v-else class="text-sm text-white/80">{{ Characters[SelectedSloth].gang.label }} oluşumunda {{ Characters[SelectedSloth].gang.grade.name }} rütbesine sahip.</p>
                        </div>
                    </div>
                    <div v-else class="inline-grid gap-5">
                        <h1 class="text-lg text-white/90 font-medium">{{ Lang.new_character }}</h1>
                        <div class="inline-grid gap-4">
                            <div>
                                <h1 class="text-xs text-white/40 italic">{{ Lang.firstname }}</h1>
                                <input type="text" placeholder="Mark" v-model="NewCharacterData.firstname" class="mt-0.5 w-full py-1 px-2 outline-none rounded-lg text-sm text-white/80 bg-gray-700/30 border border-gray-700/30 transition focus:border-gray-700">
                            </div>
                            <div>
                                <h1 class="text-xs text-white/40 italic">{{ Lang.lastname }}</h1>
                                <input type="text" placeholder="Edward" v-model="NewCharacterData.lastname" class="mt-0.5 w-full py-1 px-2 outline-none rounded-lg text-sm text-white/80 bg-gray-700/30 border border-gray-700/30 transition focus:border-gray-700">
                            </div>
                            <div>
                                <h1 class="text-xs text-white/40 italic">{{ Lang.birthday }}</h1>
                                <input type="date" v-model="NewCharacterData.birthdate" class="mt-0.5 w-full py-1 px-2 outline-none rounded-lg text-sm text-white/80 bg-gray-700/30 border border-gray-700/30 transition focus:border-gray-700">
                            </div>
                            <div>
                                <h1 class="text-xs text-white/40 italic">{{ Lang.nationality }}</h1>
                                <input type="text" placeholder="United States of America" v-model="NewCharacterData.nationality" class="mt-0.5 w-full py-1 px-2 outline-none rounded-lg text-sm text-white/80 bg-gray-700/30 border border-gray-700/30 transition focus:border-gray-700">
                            </div>
                            <div>
                                <h1 class="text-xs text-white/40 italic">{{ Lang.gender }}</h1>
                                <div class="mt-0.5 overflow-hidden rounded-lg border border-gray-600/40 divide-x divide-gray-600/40">
                                    <button @click="NewCharacterData.gender = 1" :class="{
                                        '!bg-gray-600/40': NewCharacterData.gender === 1
                                    }" class="w-1/2 py-1 bg-[#262a30] text-white/80 transition">{{ Lang.female }}</button>
                                    <button @click="NewCharacterData.gender = 0" :class="{
                                        '!bg-gray-600/40': NewCharacterData.gender === 0
                                    }" class="w-1/2 py-1 bg-[#262a30] text-white/80 transition">{{ Lang.male }}</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </Transition>
                <div class="inline-grid gap-4">
                    <div class="flex justify-center gap-1.5">
                        <div v-for="(item, index) in MaxCharacterAmount" :key="index">
                            <div v-if="Characters[index]" @click="SelectedSloth = index" :class="{
                                '!w-8 bg-gray-500': SelectedSloth === index
                            }" class="h-4 w-4 rounded-full border border-gray-500 cursor-pointer transition-all duration-300"></div>
                            <div v-else @click="SelectedSloth = index" :class="{
                                '!w-8 bg-gray-500 !text-[#1c2328]': SelectedSloth === index
                            }" class="h-4 w-4 flex items-center justify-center rounded-full border border-gray-500 text-xs text-gray-500 cursor-pointer transition-all duration-300">
                                <i class="fa-solid fa-plus"></i>
                            </div>
                        </div>
                    </div>
                    <Transition mode="out-in">
                        <div v-if="Characters[SelectedSloth]">
                            <Transition mode="out-in">
                                <div v-if="ShowDeletePopup" class="flex gap-2">
                                    <button @click="DeleteCharacter" class="w-20 py-1 rounded-lg bg-[#424a54] text-white/80 border border-gray-500/50 disabled:opacity-50">{{ Lang.select }}</button>
                                    <button @click="ShowDeletePopup = false" class="flex-1 py-1 rounded-lg bg-[#424a54] text-white/80 border border-gray-500/50 disabled:opacity-50 font-medium">{{ Lang.cancel }}</button>
                                </div>
                                <div v-else class="flex gap-2">
                                    <button @click="ShowDeletePopup = true" class="w-20 py-1 rounded-lg bg-[#424a54] text-white/80 border border-gray-500/50 disabled:opacity-50" :disabled="!CanDelete">{{ Lang.delete }}</button>
                                    <button @click="SelectCharacter" class="flex-1 py-1 rounded-lg bg-[#424a54] text-white/80 border border-gray-500/50 disabled:opacity-50 font-medium">{{ Lang.select }}</button>
                                </div>
                            </Transition>
                        </div>
                        <div v-else>
                            <button @click="CreateNewCharacter" :disabled="(() => {
                                if (!this.NewCharacterData.firstname || !this.NewCharacterData.lastname || !this.NewCharacterData.birthdate || !this.NewCharacterData.nationality) return true;
                            })()" class="w-full py-1 rounded-lg bg-[#424a54] text-white/80 border border-gray-500/50 disabled:opacity-50 font-medium">{{ Lang.create }}</button>
                        </div>
                    </Transition>
                </div>
            </div>
        </Transition>
    </div>
</template>

<script>
    import { CreateNuiEventListener, SendPost } from '@/utils.js'

    export default {
        data() {
            return {
                Lang: {},
                ShowLoader: true,
                ShowMulticharacter: false,
                CanDelete: false,
                ShowDeletePopup: false,
                MaxCharacterAmount: 5,
                SelectedSloth: 0,
                Characters: [
                    {
                        charinfo: {
                            firstname: 'Mark',
                            lastname: 'Edward',
                            gender: 0,
                            birthdate: '01/08/1998',
                            phone: '542-5634',
                            nationality: 'USA'
                        },
                        job: {
                            label: 'LSPD',
                            grade: {
                                name: 'Kıdemli Memur'
                            }
                        },
                        gang: {
                            name: 'none'
                        },
                        money: {
                            cash: 10000,
                            bank: 10000
                        }
                    }
                ],
                NewCharacterData: {
                    firstname: '',
                    lastname: '',
                    birthdate: '',
                    nationality: '',
                    gender: 1
                }
            }
        },
        methods: {
            CreateNewCharacter() {
                let NewCharacterData = this.NewCharacterData
                NewCharacterData.cid = this.Characters.length
                SendPost('CreateNewCharacter', NewCharacterData);
                this.CloseMulticharacter();
                this.SelectedSloth = 0;
                this.NewCharacterData = {
                    firstname: '',
                    lastname: '',
                    birthdate: '',
                    nationality: '',
                    gender: 1
                };
            },
            OpenMulticharacter(data) {
                this.Characters = data.characters;
                this.CanDelete = data.canDelete;
                this.MaxCharacterAmount = data.maxCharacterAmount;
                this.ShowLoader = false;
                this.ShowMulticharacter = true;
                this.Lang = data.lang;
            },
            UpdateCharacters(data) {
                this.Characters = data.characters;
            },
            CloseMulticharacter() {
                this.ShowMulticharacter = false;
                SendPost('CloseMulticharacter');
            },
            DeleteCharacter() {
                SendPost('DeleteCharacter', this.Characters[this.SelectedSloth]);
                this.ShowDeletePopup = false;
                this.SelectedSloth = 0;
            },
            SelectCharacter() {
                this.CloseMulticharacter();
                SendPost('SelectCharacter', this.Characters[this.SelectedSloth]);
            },
            ShowLoadingScreen() {
                this.ShowLoader = true;
            }
        },
        watch: {
            SelectedSloth(newValue, oldValue) {
                if (this.Characters[newValue]) SendPost('ChangeSelectedCharacter', this.Characters[newValue]);
            }
        },
        mounted() {
            CreateNuiEventListener(event => this[event.data.action](event.data.array));
        }
    }
</script>

<style>
    body {
        font-family: 'Inter', sans-serif;
    }

    .v-enter-active,
    .v-leave-active {
        transition: opacity 0.3s ease;
    }

    .v-enter-from,
    .v-leave-to {
        opacity: 0;
    }

    .gradient {
        background: linear-gradient(92.83deg, #00C6FF 0%, #38EF7D 95.09%);
    }
</style>